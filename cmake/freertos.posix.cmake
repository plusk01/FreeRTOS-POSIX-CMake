set(FREERTOS_KERNEL_VERSION 10.4.4)

include(FetchContent)
FetchContent_Declare(kernel
  GIT_REPOSITORY https://github.com/FreeRTOS/FreeRTOS-Kernel
  GIT_TAG "V${FREERTOS_KERNEL_VERSION}"
)
FetchContent_MakeAvailable(kernel)

function(freertos_target_add_kernel TARGET)
  # see Source Files: https://www.freertos.org/Creating-a-new-FreeRTOS-project.html
  target_sources(${TARGET} PRIVATE
    # minimum required
    ${kernel_SOURCE_DIR}/tasks.c
    ${kernel_SOURCE_DIR}/queue.c
    ${kernel_SOURCE_DIR}/list.c
    # port-specific sources will be added below
    ${kernel_SOURCE_DIR}/portable/MemMang/heap_3.c # see https://www.freertos.org/a00111.html

    # optional kernel sources
    ${kernel_SOURCE_DIR}/timers.c
    ${kernel_SOURCE_DIR}/event_groups.c
    ${kernel_SOURCE_DIR}/stream_buffer.c
  )

  # POSIX port of kernel
  target_sources(${TARGET} PRIVATE
    ${kernel_SOURCE_DIR}/portable/ThirdParty/GCC/Posix/port.c
    ${kernel_SOURCE_DIR}/portable/ThirdParty/GCC/Posix/utils/wait_for_event.c
  )

  target_include_directories(${TARGET} PUBLIC
    $<BUILD_INTERFACE:${kernel_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${kernel_SOURCE_DIR}/portable/ThirdParty/GCC/Posix>
    $<BUILD_INTERFACE:${kernel_SOURCE_DIR}/portable/ThirdParty/GCC/Posix/utils>
  )

  target_link_libraries(${TARGET} pthread)
endfunction()