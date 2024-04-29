// afl_integration.c
// @author: Shane Zhu 
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define ARRAY_SIZE 1000000

// Function to measure the latency and bandwidth of memory accesses
void measure_memory_access(uint64_t *array, int array_size, int stride) {
    uint64_t start, end;
    volatile uint64_t result = 0; // Prevent compiler optimizations

    start = __builtin_ia32_rdtsc(); // Read Time-Stamp Counter
    for (int i = 0; i < array_size; i += stride) {
        result += array[i]; // Access memory with the specified stride
    }
    end = __builtin_ia32_rdtsc();

    uint64_t cycles = end - start;
    double time_seconds = (double)cycles / (double)(2.6 * 1000000000); // CPU frequency of 2.6 GHz

    // Calculate memory bandwidth (accesses per second)
    double bandwidth = (double)array_size / (double)time_seconds;

    printf("Memory access latency with stride %d: %lu cycles (%f seconds), bandwidth: %.2f accesses/second\n",
           stride, cycles, time_seconds, bandwidth);
}

int main() {
    // Allocate memory dynamically
    uint64_t *array = (uint64_t *)malloc(ARRAY_SIZE * sizeof(uint64_t));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    // Read input data from AFL (stdin)
    char input[100]; // Adjust buffer size as needed
    if (read(0, input, sizeof(input)) <= 0) {
        fprintf(stderr, "Error reading input from AFL\n");
        return 1;
    }

    // Initialize array with sequential values
    for (int i = 0; i < ARRAY_SIZE; i++) {
        array[i] = i;
    }

    printf("Measuring memory access latency and bandwidth...\n");
    printf("Array size: %d elements\n", ARRAY_SIZE);

    // Measure memory access latency and bandwidth with different strides
    for (int stride = 1; stride <= 64; stride *= 2) {
        measure_memory_access(array, ARRAY_SIZE, stride);
    }

    // Free allocated memory
    free(array);

    return 0;
}
