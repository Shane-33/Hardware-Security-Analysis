// hardware_test.c
// @author: Shane Zhu 

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

#define DEFAULT_ARRAY_SIZE 1000000

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
    int array_size = DEFAULT_ARRAY_SIZE;
    uint64_t *array = NULL;

    // Allocate memory dynamically
    array = (uint64_t *)malloc(array_size * sizeof(uint64_t));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    // Initialize array with sequential values
    for (int i = 0; i < array_size; i++) {
        array[i] = i;
    }

    printf("Measuring memory access latency and bandwidth...\n");
    printf("Array size: %d elements\n", array_size);

    // Measure memory access latency and bandwidth with different strides
    for (int stride = 1; stride <= 64; stride *= 2) {
        measure_memory_access(array, array_size, stride);
    }

    // Free allocated memory
    free(array);

    return 0;
}




// #include <stdio.h>
// #include <stdint.h>
// #include <stdlib.h>
// #include <time.h>

// #define ARRAY_SIZE 1000000

// // Function to measure the latency of memory accesses
// void measure_latency(uint64_t *array, int stride) {
//     uint64_t start, end;
//     volatile uint64_t result; // Prevent compiler optimizations

//     start = __builtin_ia32_rdtsc(); // Read Time-Stamp Counter
//     for (int i = 0; i < ARRAY_SIZE; i += stride) {
//         result = array[i]; // Access memory with the specified stride
//     }
//     end = __builtin_ia32_rdtsc();

//     printf("Memory access latency with stride %d: %lu cycles\n", stride, end - start);
// }

// int main() {
//     // Allocate memory dynamically
//     uint64_t *array = (uint64_t *)malloc(ARRAY_SIZE * sizeof(uint64_t));
//     if (array == NULL) {
//         fprintf(stderr, "Memory allocation failed\n");
//         return 1;
//     }

//     // Initialize array with sequential values
//     for (int i = 0; i < ARRAY_SIZE; i++) {
//         array[i] = i;
//     }

//     // Measure memory access latency with different strides
//     printf("Measuring memory access latency...\n");
//     measure_latency(array, 1);  // Stride 1 (sequential access)
//     measure_latency(array, 2);  // Stride 2
//     measure_latency(array, 4);  // Stride 4
//     measure_latency(array, 8);  // Stride 8

//     // Free allocated memory
//     free(array);

//     return 0;
// }