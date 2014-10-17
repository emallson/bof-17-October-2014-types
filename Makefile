LANGUAGES=c cpp haskell python racket

all: build-all run-all

build-all: $(LANGUAGES:%=build-%)

build-c: c/genprime.c
	gcc -lgmp $^ -o $(^:%.c=%)

build-cpp: cpp/genprime.cpp
	g++ -lgmp -lgmpxx -std=c++11 $^ -o $(^:%.cpp=%)

build-haskell: haskell/Main.hs
	cd haskell; cabal build

build-python: python/genprime-typed.py
	mypy $^

build-racket: racket/genprime.rkt racket/genprime-typed.rkt
	raco make $^

run-all: $(LANGUAGES:%=run-%)

run-c:
	./c/genprime

run-cpp:
	./cpp/genprime

run-haskell:
	./haskell/dist/build/rsa-demo/rsa-demo

run-python:
	python3 ./python/genprime.py
	python3 ./python/genprime-typed.py

run-racket:
	racket ./racket/genprime.rkt
	racket ./racket/genprime-typed.rkt
