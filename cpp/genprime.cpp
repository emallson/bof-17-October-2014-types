#include <gmpxx.h>
#include <iostream>
#include <time.h>

mpz_class min, max;
gmp_randstate_t gen;

bool fermatTest(mpz_class& x, unsigned int n) {
  unsigned int i;
  mpz_class k,
    upper_bound = x - 3,
    x_1 = x - 1;

  for(i = 0; i < n; ++i) {
    mpz_urandomm(k.get_mpz_t(), gen, upper_bound.get_mpz_t());
    k += 2;
    mpz_powm(k.get_mpz_t(), k.get_mpz_t(), x_1.get_mpz_t(), x.get_mpz_t());
    if(k != 1) {
      return false;
    }
  }
  return true;
}

bool isPrime(mpz_class& x) {
  return x % 2 != 0 && fermatTest(x, 10);
}

mpz_class genPrime() {
  mpz_class dist = max - min,
    result;

  do {
    mpz_urandomm(result.get_mpz_t(), gen, dist.get_mpz_t());
    result += min;
  } while(!isPrime(result));

  return result;
}

int main(int argc, char *argv[])
{
  mpz_ui_pow_ui(min.get_mpz_t(), 2, 512);
  mpz_ui_pow_ui(max.get_mpz_t(), 2, 513);
  max--;

  gmp_randinit_mt(gen);
  gmp_randseed_ui(gen, time(NULL));

  mpz_class prime = genPrime();
  std::cout << prime << std::endl;
  return 0;
}
