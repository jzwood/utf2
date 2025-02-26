module Main where

import Test.HUnit
import Lib

toBinTests :: Test
toBinTests = TestList
      [ TestCase $ assertEqual "toBin" (toBin 3) [1, 1]
      , TestCase $ assertEqual "toBin" (toBin 128513) [1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1]
      , TestCase $ assertEqual "toBin" (toBin 0) [0]
      ]

toDecTests :: Test
toDecTests = TestList
      [ TestCase $ assertEqual "toDec" (toDec [1, 1]) 3
      , TestCase $ assertEqual "toDec" (toDec [1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1]) 128513
      , TestCase $ assertEqual "toDec" (toDec [0]) 0
      ]

roundTripTests :: Test
roundTripTests = TestList
      [ TestCase $ assertEqual "round trip" (decode $ encode "J\n") "J\n"
      , TestCase $ assertEqual "round trip" (decode $ encode "😁") "😁"
      , TestCase $ assertEqual "round trip" (decode $ encode "ab") "ab"
      , TestCase $ assertEqual "round trip" (decode $ encode "hello world") "hello world"
      , TestCase $ assertEqual "round trip" (decode $ encode "😂😎😜") "😂😎😜"
      , TestCase $ assertEqual "round trip" (decode $ encode "so cool 😭 ~~~ !! 😴\n") "so cool 😭 ~~~ !! 😴\n"
      ]

tests :: Test
tests = TestList [ toBinTests, toDecTests, roundTripTests]

main :: IO ()
main = runTestTTAndExit tests
