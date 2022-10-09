cmake_minimum_required(VERSION 3.0.0)
project(fib)

set(CMAKE_CXX_STANDARD 17)

option(TEST_OPT "build test version" OFF)
option(DEBUG "build debug version" ON)

add_subdirectory(fib_lib)

add_executable(${PROJECT_NAME} main.cpp)

if(TEST_OPT)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -coverage -lgcov" )
endif()


target_include_directories(${PROJECT_NAME} PUBLIC ${FIB_LIB_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${FIB_LIB_LIBRARIES})

