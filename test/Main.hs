module Main where

import Test.HUnit
import Lib

tests :: Test
tests = TestList
      [ TestCase $ assertEqual "Example" (1 + 1) 2
      , TestCase $ assertEqual "toBin" (toBin 3) [1, 1]
      ]


main :: IO ()
main = runTestTTAndExit tests
