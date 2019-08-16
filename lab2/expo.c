#include <stdio.h>

int expo1(int x, int n) {
    int i, result = 1;
    for (i=0; i<n; i++)
        result = result*x;
    return result;
}

int expo2(int x, int n) {
    if (n == 0) return 1;
    return expo2(x, n-1)*x;
}

int expo3(int x, int n) {
    int fh, sh;
    if (n == 0) return 1;
    fh = expo3(x, n/2);
    sh = expo3(x, n/2);
    if ((n % 2) == 1)
        return x*fh*sh;
    else
        return fh*sh;
}

int main()
{
    int result;
    result = expo1(4, 7);
    printf("Expo1 result: %d\n", result);
    result = expo2(4, 7);
    printf("Expo2 result: %d\n", result);
    result = expo3(4, 7);
    printf("Expo3 result: %d\n", result);   
    return 0;
}
