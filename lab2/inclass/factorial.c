#include <stdio.h>

int fact(int n) {
   if (n < 1) return 1;
   return fact(n-1)*n;
}

int main() {
    int x;
    x = fact(5);
    printf("%d\n", x);
    return 0;
}
