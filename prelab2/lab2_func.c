#include <stdio.h>

int min_three(int x, int y, int z)
{
    if (x < y)
        if (z < x)
            return z;
        else
            return x;
    else
        if (z < y)
            return z;
        else
            return y;
}

int max_three(int x, int y, int z)
{
    int max;

    max = x;
    if (y > max)
        max = y;
    if (z > max)
        max = z;
    return max;
}

int foo(int x, int y)
{
    int z = 0xbeef;

    z = max_three(y^z, x^z, y^x);
    z = min_three(x, y, z);
    return z;
}

int main()
{
    printf("Result = %x\n", foo(0xabcd, 0xdead));
    return 0;
}
