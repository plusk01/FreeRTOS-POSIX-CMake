FreeRTOS-POSIX-CMake Example
============================

This repo contains FreeRTOS example applications that run on the [POSIX/Linux port of FreeRTOS](https://www.freertos.org/FreeRTOS-simulator-for-Linux.html).

Each application is created as its own CMake project (in the `apps` directory). The POSIX port is configured in the `cmake/freertos.posix.cmake` file. Each CMake project includes this port file, which (1) downloads the appropriate verion of the FreeRTOS kernel, and (2) adds the kernel and port sources to the CMake project's main target via the `freertos_target_add_kernel` CMake function. For example, the `blinky` demo app has the following in its `CMakeLists.txt`:

```cmake
include(${CMAKE_SOURCE_DIR}/../../cmake/freertos.posix.cmake)

add_executable(blinky src/main.c src/main_blinky.c src/console.c)
target_include_directories(blinky PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>)
target_include_directories(blinky PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)
target_compile_definitions(blinky PRIVATE projCOVERAGE_TEST=1)
freertos_target_add_kernel(blinky)
```

---

The goal of this repo is similar to [FreeRTOS-CMake](https://github.com/jonathanmichel/FreeRTOS-CMake) in that CMake is used to build a FreeRTOS application. However, the difference is that this version (1) uses more modern CMake and target-specific functions, (2) better separates the core kernel and the application sources/includes, and (3) is more scalable by abstracting kernel-specific sources into a port-specific cmake file (e.g., `freertos.posix.cmake`).