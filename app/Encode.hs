module Encode where

import Data.Functor
import Data.Function
import Data.Char (ord)
import Data.List (intersperse)
import Data.List.Split (chunksOf)

--import Data.ByteString.Lazy (ByteString)
--import Data.ByteString.Lazy.Char8 (pack)
import Data.Word (Word8)

import Data.ByteString (ByteString, pack)
--pack :: [Word8] -> ByteString

--newtype Utf2 = Utf2 BS.ByteString

type Bit = Int

toBin :: Int -> [Bit]
toBin 0 = [0]
toBin n = helper n

toDec :: [Int] -> Int
toDec xs = sum $ zipWith (*) [128, 64, 32, 16, 8, 4, 2, 1] xs

helper :: Int -> [Bit]
helper 0 = []
helper n = let (q,r) = n `divMod` 2 in r : helper q

toUtf2 :: [Bit] -> [Bit]
toUtf2 [] = []
toUtf2 (x:xs) = reverse $ x : 0 : intersperse 1 xs

toByte :: Int -> Word8
toByte = toEnum

toBytes :: [Int] -> ByteString
toBytes xs = xs
         <&> toByte
           & pack

encode :: String -> ByteString
encode cs = cs
        >>= (chunksOf 8 . toUtf2 . toBin . ord)
        <&> toDec
          & toBytes

