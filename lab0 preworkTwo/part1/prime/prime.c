#include <stdio.h>
void IsPrime(int n)
{
    int isPrime = 1;
    if (n <= 1) {
       isPrime = 0;
    }
    else
    {
        for (int i = 2; i*i <= n; i++) {
            if (n % i == 0) {
                isPrime = 0;
                break;
            }
        }
    }
    if (isPrime) {
        printf("YES\n");
    } else {
        printf("NO\n");
    }
}
int main() {
    int n;
    scanf("%d", &n);
    IsPrime(n);
    return 0;
}