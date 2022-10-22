#include <iostream>
#include "fib.h"

int fib(int n) {
    if (n <= 1)
    {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

void foo()
{
    std::cout << "hello" << std::endl;
}
