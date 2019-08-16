#include <stdio.h>

void rec_func(int n)
{
    if (n > 0)
    {
        printf("%d\n", n);
        rec_func(n - 2);
        rec_func(n - 3);
        printf("%d\n", n);
    }
}

int main()
{
    rec_func(5);
    return 0;
}
