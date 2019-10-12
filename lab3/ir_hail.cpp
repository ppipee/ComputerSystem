#include <iostream>

using namespace std;

int r_hailstone(int n)
{
    if (n == 1) return 0;
    else if ((n % 2) == 0) return 1 + r_hailstone(n/2);
    else return 1 + r_hailstone(3*n+1);
}

int i_hailstone(int n)
{
    int i = 0;
    while (n != 1)
    {
        i = i + 1;
        if ((n % 2) == 0)
            n = n / 2;
        else
            n = 3 * n + 1;
    }
    return i;
}

int main(){
    int inp;
    cin >> inp;
    cout << r_hailstone(inp) << endl;
    cout << i_hailstone(inp) << endl;
}