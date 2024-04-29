// aggressive_bit_toggle.c
// @author: Shane Zhu 


#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/time.h>

#define MEM_SIZE (1 << 30) // 1 GB
#define TOGGLES 1000000

// Function to toggle bits in memory aggressively
void toggle_bits(char *mem) {
    struct timeval start, end;
    gettimeofday(&start, NULL); // Start timer

    // Toggle bits in memory
    for (int i = 0; i < TOGGLES; i++) {
        size_t offset = (i << 12) % MEM_SIZE; // Deterministic offset calculation
        mem[offset] ^= 1; // Toggle a single bit
    }

    gettimeofday(&end, NULL); // End timer
    double elapsed_time = (end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec) / 1e6;
    printf("Time taken to toggle bits: %.6f seconds\n", elapsed_time);
}

int main() {
    // Allocate memory using mmap
    char *mem = (char *)mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    if (mem == MAP_FAILED) {
        perror("Memory allocation failed");
        return 1;
    }

    // Initialize memory
    memset(mem, 0, MEM_SIZE);

    // Toggle bits aggressively and measure performance
    toggle_bits(mem);

    // Free allocated memory
    munmap(mem, MEM_SIZE);

    return 0;
}
