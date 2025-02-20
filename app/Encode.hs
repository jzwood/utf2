module Encode where

import Data.Functor
import Data.Function
import Data.Char (ord)
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

helper :: Int -> [Bit]
helper 0 = []
helper n = let (q,r) = n `divMod` 2 in r : helper q

toDec :: [Int] -> Int
toDec xs = sum $ zipWith (*) [128, 64, 32, 16, 8, 4, 2, 1] xs

toUtf2 :: [Bit] -> [Bit]
toUtf2 [] = []
toUtf2 (x:xs) = reverse $ x : 0 : (xs >>= (:[1]))

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

-- 1110 1011 1011 00

-- J = 1001010  code point
--     11 10 10 11 10 11 00
--     11101011 10110000

-- :%!xxd -b
