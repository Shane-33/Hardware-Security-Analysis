// @author: Shane Zhu 

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#define NUM_ACCESS 1000000 // Number of accesses
#define PAGE_SIZE 4096     // Typical page size on x86 systems

int main() {
    // Allocate memory for two adjacent rows (8 KB)
    size_t size = 2 * PAGE_SIZE;
    uint8_t* mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    if (mem == MAP_FAILED) {
        perror("Failed to allocate memory");
        exit(EXIT_FAILURE);
    }

    // Initialize memory to some known values
    memset(mem, 0xAA, size);

    printf("Starting Rowhammer test...\n");

    // Perform Rowhammer attack
    for (int i = 0; i < NUM_ACCESS; i++) {
        // Access both memory rows
        volatile uint8_t dummy1 = mem[i % PAGE_SIZE];
        volatile uint8_t dummy2 = mem[(i + PAGE_SIZE) % (2 * PAGE_SIZE)];
    }

    printf("Rowhammer test completed.\n");

    // Clean up
    if (munmap(mem, size) == -1) {
        perror("Failed to unmap memory");
        exit(EXIT_FAILURE);
    }

    return 0;
}
