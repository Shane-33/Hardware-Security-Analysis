# Hardware Security Analysis and SecureOS-VulnerabilityMitigation

This repository contains various tools and tests related to hardware security analysis and vulnerability mitigation.

## Overview

### DRAM "Rowhammer" Problem

"Rowhammer" is a problem with recent DRAM modules in which repeatedly accessing a row of memory can cause bit flips in adjacent rows. This repository contains programs for testing the rowhammer problem, which run as normal userland processes.

The rowhammer problem is described in Yoongu Kim et al's paper, "[Flipping Bits in Memory Without Accessing Them: An Experimental Study of DRAM Disturbance Errors](http://users.ece.cmu.edu/~yoonguk/papers/kim-isca14.pdf)" (2014).

## Directory Structure

### Tests

#### rowhammer_test_v2.c

- **Description**: This file contains an updated version of the Rowhammer test, focusing on memory manipulation techniques.
- **Language**: C
- **Usage**:
  1. Navigate to the `tests` directory.
  2. Compile the test file:
     ```bash
     gcc rowhammer_test_v2.c -o rowhammer_test_v2
     ```
  3. Run the test:
     ```bash
     ./rowhammer_test_v2
     ```

#### rowhammer_test.cc

- **Description**: This file contains the original Rowhammer test written in C++.
- **Language**: C++
- **Usage**:
  1. Navigate to the `tests` directory.
  2. Compile the test file:
     ```bash
     g++ rowhammer_test.cc -o rowhammer_test
     ```
  3. Run the test:
     ```bash
     ./rowhammer_test
     ```

#### rowhammer.c

- **Description**: This file provides the core implementation of the Rowhammer test in C.
- **Language**: C
- **Usage**:
  1. Navigate to the `tests` directory.
  2. Compile the test file:
     ```bash
     gcc rowhammer.c -o rowhammer
     ```
  3. Run the test:
     ```bash
     ./rowhammer
     ```

## Building and Running the Tests

You can also use the provided `make.sh` script to build and run the tests:

```bash
./make.sh
./rowhammer_test
