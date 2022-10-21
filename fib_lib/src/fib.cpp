#include "stdafx.h"
#include "fib.h"

int fib(int n) {
    // SANITIZE_OPT = ON
    // char *buf = new char[2];
    // buf[2] = 'f';

    // std::cout << "hello" << std::endl;

    if (n <=  1) 
    {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}
