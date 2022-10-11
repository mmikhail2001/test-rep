cmake_minimum_required(VERSION 3.0.0)
project(fib_lib)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -Werror")

if(TEST_OPT)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC -O0")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -coverage -lgcov" )
elseif(DEBUG_OPT)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -O0")
else() 
    # релиз-версия
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -O3")
endif()

file(GLOB_RECURSE SOURCES       src/*.cpp)
file(GLOB_RECURSE INCLUDE_DIRS  ${CMAKE_CURRENT_SOURCE_DIR}/include)
file(GLOB_RECURSE HEADERS       ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h)

add_library(${PROJECT_NAME} ${SOURCES})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

# без   PARENT_SCOPE для тестов
# с     PARENT_SCOPE для главного CMakeLists.txt
set(FIB_LIB_LIBRARIES       ${PROJECT_NAME}                 )
set(FIB_LIB_LIBRARIES       ${PROJECT_NAME}     PARENT_SCOPE)
set(FIB_LIB_INCLUDE_DIRS    ${INCLUDE_DIRS}     PARENT_SCOPE)
set(FIB_LIB_INCLUDE_DIRS    ${INCLUDE_DIRS}                 )

if (TEST_OPT)
    enable_testing()
    add_subdirectory(tests)
endif()
