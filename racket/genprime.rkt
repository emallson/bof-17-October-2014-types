#lang racket

(require (only-in math modular-expt random-integer))

(define (divides m n)
  (= (modulo n m) 0))

(define (fermat-test n x)
  (if (zero? n)
      #t
      (let ((k (random-integer 2 (- x 1))))
        (and
         (= (modular-expt k (- x 1) x) 1)
         (fermat-test (- n 1) x)))))

(define (prime? x)
  (and (not (divides 2 x))
       (fermat-test 10 x)))

(define (gen-prime min max)
  (let* ((x (random-integer min max)))
    (if (prime? x)
        x
        (gen-prime min max))))

(displayln (gen-prime (expt 2 512) (- (expt 2 513) 1)))
