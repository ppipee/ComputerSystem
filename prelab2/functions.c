#include <stdio.h>

int fact(int n)
{
    int i, f = 1;

    for (i = n; i > 1; i--)
        f = f * i;
    return f;
}

int sum_two_fact(int a, int b)
{
    int x, y, z;

    x = fact(a);
    y = fact(b);
    z = x + y;
    return z;
}

int main()
{
    int init_result = 1000, temp;
    
    temp = sum_two_fact(5, 3);
    init_result += temp;
    printf("%d\n", init_result);
    return 0;
}
