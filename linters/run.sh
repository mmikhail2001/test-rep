#!/usr/bin/env bash

# set -o pipefail

function print_header {
    echo -e "\n***** ${1} *****"
}

function check_log {
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
check_log "cppcheck main.cpp fib_lib/src fib_lib/include fib_lib/tests --enable=all --inconclusive --error-exitcode=1 -Ifib_lib/include --suppress=missingIncludeSystem" "\(information\)"

# # ********** clang-tidy ********** 
print_header "RUN clang-tidy"
check_log "clang-tidy main.cpp fib_lib/src/*.cpp  fib_lib/tests/*.cpp  -warnings-as-errors=* -extra-arg=-std=c++17 -- -Ifib_lib/include -x c++" "Error (?:reading|while processing)"
# fib_lib/include/*.h


# # ********** cpplint ********** 
print_header "RUN cpplint"
check_log "cpplint --extensions=cpp *.cpp fib_lib/src/*.cpp fib_lib/tests/*.cpp"    "Can't open for reading"
check_log "cpplint --extensions=h   fib_lib/include/*.h"                        "Can't open for reading"
print_header "SUCCESS"
