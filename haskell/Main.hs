module Main where

import System.Random
import Crypto.Number.ModArithmetic (expFast)

newtype Prime = Prime Integer

instance Show Prime where
  show x = show (unPrime x)

unPrime :: Prime -> Integer
unPrime (Prime p) = p

divides :: Integer -> Integer -> Bool
divides m n =
  n `mod` m == 0

fermatTest :: [Integer] -> Integer -> Bool
fermatTest ks x = case ks of
                   [] -> True
                   (k:rest) -> expFast k (x-1) x == 1
                               && fermatTest rest x

isPrime :: (Integer, StdGen) -> Bool
isPrime (x,g) = not (2 `divides` x)
                && fermatTest (take 10 $ randomRs (2,x-2) g) x

genPrime :: (Integer, Integer) -> IO Prime
genPrime range = do
  gen <- newStdGen
  return $ Prime $ fst (until isPrime (randomR range . snd) (randomR range gen))

main :: IO ()
main = do prime <- genPrime (2^512, 2^513-1)
          print prime
