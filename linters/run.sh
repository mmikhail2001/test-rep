#!/usr/bin/env bash

set -o pipefail

function print_header() {
    echo -e "\n***** ${1} *****"
}

function check_log() {
    LOG=$( { ${1}; } 2>&1 )
    STATUS=$?
    echo "$LOG"
    if echo "$LOG" | grep -q -E "${2}"
    then
        exit 1
    fi

    if [ $STATUS -ne 0 ]
    then
        exit $STATUS
    fi
}

# ********** cppcheck ********** 
print_header "RUN cppcheck"
check_log "cppcheck main.cpp fib_lib tests --enable=all --inconclusive --error-exitcode=1 -Ifib_lib --suppress=missingIncludeSystem" "\(information\)"

# ********** clang-tidy ********** 
print_header "RUN clang-tidy files .cpp"
check_log "clang-tidy   -p main.cpp fib_lib/*.cpp  tests/*.cpp fib_lib/*.h  -warnings-as-errors=* -extra-arg=-std=c++17 -- -Ifib_lib -x c++" "Error (?:reading|while processing)"


# ********** cpplint ********** 
print_header "RUN cpplint"
check_log "cpplint --extensions=cpp *.cpp fib_lib/*.cpp tests/*.cpp"    "Can't open for reading"
check_log "cpplint --extensions=h   fib_lib/*.h"                        "Can't open for reading"

print_header "SUCCESS"
