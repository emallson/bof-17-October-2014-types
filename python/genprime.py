from random import randrange

def divides(m, n):
    return n % m == 0

def fermatTest(x, n):
    for i in range(n):
        k = randrange(2, x-2)
        if pow(k, x-1, x) == 1:
            return False
    return True

def isPrime(x):
    return x % 2 != 0 and fermatTest(x, 10)

def genPrime(low, high):
    x = randrange(low, high)
    while(not isPrime(x)):
        x = randrange(low, high)
    return x

if __name__ == "__main__":
    print(genPrime(pow(2,512), pow(2,513)-1))
