#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

void SieveOfEratosthenes(int n)
{
    bool prime[n+1];
    memset(prime, true, sizeof(prime));

    for (int p=2; p*p<=n; p++)
    {
        // If prime[p] is not changed, then it is a prime
        if (prime[p] == true)
        {
            // Update all multiples of p
            for (int i=p*2; i<=n; i += p)
                prime[i] = false;
        }
    }
    // Print all prime numbers
    for (int p=2; p<=n; p++){
        if (prime[p]){
            printf("%d\n",p);
        }
    }
}
// Driver Program to test above function
int main()
{
    int n = 1000;
    SieveOfEratosthenes(n);
    return 0;
}