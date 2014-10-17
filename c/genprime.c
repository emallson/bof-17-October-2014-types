#include <gmp.h>
#include <time.h>

mpz_t min, max;
gmp_randstate_t gen;

short fermatTest(mpz_t x, unsigned int n) {
  unsigned int i;
  mpz_t k, upper_bound, x_1;
  mpz_inits(k, upper_bound, x_1, NULL);

  mpz_sub_ui(upper_bound, x, 3);
  mpz_sub_ui(x_1, x, 1);

  for(i = 0; i < n; ++i) {
    mpz_urandomm(k, gen, upper_bound);
    mpz_add_ui(k, k, 2);
    mpz_powm(k, k, x_1, x);
    if(!mpz_cmp_ui(k, 1)) {
      return 0;
    }
  }
  return 1;
}

short isPrime(mpz_t x) {
  return mpz_even_p(x) && fermatTest(x, 10);
}

void genPrime(mpz_t result) {
  mpz_t dist;
  mpz_init(dist);

  mpz_sub(dist, max, min);

  do {
    mpz_urandomm(result, gen, dist);
    mpz_add(result, result, min);
  } while(!isPrime(result));
}

int main(int argc, char *argv[])
{
  mpz_t prime;
  /* initialize bounds */
  mpz_inits(min,max,prime, NULL);
  mpz_ui_pow_ui(min, 2, 512);
  mpz_ui_pow_ui(max, 2, 513);
  mpz_sub_ui(max, max, 1);

  /* initialize rng */
  gmp_randinit_mt(gen);
  gmp_randseed_ui(gen, time(NULL));

  genPrime(prime);

  gmp_printf("%Zd\n", prime);
  return 0;
}
