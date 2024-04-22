// rowhammer_test_v2.c
// @author: Shane Zhu 


#include <assert.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>

const size_t mem_size = 1 << 30;
const int toggles = 540000;

char *g_mem;

char *pick_addr() {
    static char *last_addr = NULL;
    static char *all_addrs[8] = {NULL};
    static int current_addr = 0;

    char *addr;
    do {
        size_t offset = (rand() << 12) % mem_size;
        addr = g_mem + offset;
    } while (addr == last_addr); // Ensure a new address is picked

    all_addrs[current_addr++] = addr;
    if (current_addr == 8) {
        current_addr = 0;
        last_addr = all_addrs[rand() % 8];
    } else {
        last_addr = addr;
    }
    
    return addr;
}


struct Timer {
    struct timeval start_time_;
};

void init_timer(struct Timer *timer) {
    int rc = gettimeofday(&timer->start_time_, NULL);
    assert(rc == 0);
}

double get_diff(struct Timer *timer) {
    struct timeval end_time;
    int rc = gettimeofday(&end_time, NULL);
    assert(rc == 0);
    return (end_time.tv_sec - timer->start_time_.tv_sec +
            (double)(end_time.tv_usec - timer->start_time_.tv_usec) / 1e6);
}

static void toggle(int iterations, int addr_count) {
    struct Timer timer;
    init_timer(&timer);
    
    printf("--- Memory Access Details ---\n");
    for (int j = 0; j < iterations; j++) {
        uint32_t *addrs[addr_count];
        for (int a = 0; a < addr_count; a++)
            addrs[a] = (uint32_t *)pick_addr();

        uint32_t sum = 0;
        for (int i = 0; i < toggles; i++) {
            for (int a = 0; a < addr_count; a++)
                sum += *addrs[a] + 1;
            for (int a = 0; a < addr_count; a++)
                asm volatile("clflush (%0)" : : "r"(addrs[a]) : "memory");
        }

        if (sum != 0) {
            printf("error: sum=%x\n", sum);
            exit(1);
        }
    }

    double time_taken = get_diff(&timer);
    printf("\n--- Memory Access Statistics ---\n");
    printf("Total Memory Accesses: %d\n", toggles);
    printf("Addresses Accessed: %d\n", addr_count);
    printf("Average Access Time: %.1f ms per address set\n", time_taken / iterations * 1e3);
    printf("Total Time Taken: %.2f seconds for %d address sets\n", time_taken, iterations);
    printf("Nanoseconds per Memory Access: %.3f nanoseconds\n", time_taken / (iterations * toggles) * 1e9);
    printf("Accesses per Address per Refresh Period: %d accesses per address per %d ms refresh period\n",
           (int)(64 * 1e-3 * iterations * toggles / time_taken), 64);
}

void main_prog() {
    g_mem = (char *)mmap(NULL, mem_size, PROT_READ | PROT_WRITE,
                         MAP_ANON | MAP_PRIVATE, -1, 0);
    assert(g_mem != MAP_FAILED);

    printf("clear\n");
    memset(g_mem, 0xff, mem_size);

    struct Timer t;
    init_timer(&t);
    
    int iter = 0;
    for (;;) {
        printf("\nIteration %d (after %.2f seconds)\n", iter++, get_diff(&t));
        toggle(10, 8);

        struct Timer check_timer;
        init_timer(&check_timer);
        
        uint64_t *end = (uint64_t *)(g_mem + mem_size);
        uint64_t *ptr;
        int errors = 0;
        for (ptr = (uint64_t *)g_mem; ptr < end; ptr++) {
            uint64_t got = *ptr;
            if (got != ~(uint64_t)0) {
                printf("error at %p: got 0x%" PRIx64 "\n", ptr, got);
                errors++;
            }
        }
        printf("\n--- Potential Bit Flip Detection ---\n");
        if (errors == 0) {
            printf("No bit flip detected in the tested memory addresses.\n");
        } else {
            printf("%d bit flip(s) detected in the tested memory addresses.\n", errors);
            exit(1);
        }
        printf("Checking for bit flips took %.2f seconds\n", get_diff(&check_timer));
    }
}

int main() {
    int pid = fork();
    if (pid == 0) {
        main_prog();
        _exit(1);
    }

    int status;
    if (waitpid(pid, &status, 0) == pid) {
        printf("** exited with status %d (0x%x)\n", status, status);
    }

    for (;;) {
        sleep(999);
    }
    return 0;
}
