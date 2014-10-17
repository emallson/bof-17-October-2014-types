from random import randrange

class Prime(int):
    pass

def divides(m: int, n: int) -> bool:
    return n % m == 0

def fermatTest(x: int, n: int) -> bool:
    for i in range(n):
        k = randrange(2, x-2)
        if pow(k, x-1, x) == 1:
            return False
    return True

def isPrime(x: int) -> bool:
    return x % 2 != 0 and fermatTest(x, 10)

def genPrime(low: int, high: int) -> Prime:
    x = randrange(low, high)
    while(not isPrime(x)):
        x = randrange(low, high)
    return Prime(x)

if __name__ == "__main__":
    print(genPrime(pow(2,512), pow(2,513)-1))
