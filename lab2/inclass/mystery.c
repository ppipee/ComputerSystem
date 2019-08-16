#include <stdio.h>


int mystery(int a, int b) {
   if (0 == b) return 0;
   else return a + mystery(a, b-1);
}

int main() {
    int x;
    x = mystery(10, 30);
    printf("Output is %d\n", x);
    return 0;
}

