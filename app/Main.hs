module Main where

import qualified Data.ByteString as B
import Encode (encode)

main :: IO ()
main = B.putStr $ encode "J"
