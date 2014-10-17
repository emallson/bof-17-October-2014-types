#!/bin/zsh
echo "Timing C:"
time (repeat 10 {c/genprime > /dev/null; sleep 1})
echo "Timing C++:"
time (repeat 10 {cpp/genprime > /dev/null; sleep 1})
echo "Timing Haskell:"
time (repeat 10 {haskell/dist/build/rsa-demo/rsa-demo > /dev/null})
echo "Timing Racket:"
time (repeat 10 {racket racket/genprime.rkt > /dev/null})
echo "Timing Typed Racket:"
time (repeat 10 {racket racket/genprime-typed.rkt > /dev/null})
echo "Timing Python:"
time (repeat 10 {python3 python/genprime.py > /dev/null})
echo "Timing Typed Python:"
time (repeat 10 {python3 python/genprime-typed.py > /dev/null})
