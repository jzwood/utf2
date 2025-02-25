{-# LANGUAGE LambdaCase #-}

module Lib where

import Data.Functor
import Data.Function
import Data.Char (ord, chr)
import Data.List.Split (chunksOf)
import Data.Word (Word8)
import Data.ByteString (ByteString, pack, unpack)

type Bit = Int

toBin :: Int -> [Bit]
toBin 0 = [0]
toBin x = reverse $ bin x
  where
    bin :: Int -> [Bit]
    bin 0 = []
    bin n = let (q,r) = n `divMod` 2 in r : bin q

toDec :: [Int] -> Int
toDec xs = sum $ zipWith (*) [128, 64, 32, 16, 8, 4, 2, 1] (padLeft 0 8 xs)

toUtf2 :: [Bit] -> [Bit]
toUtf2 [] = []
toUtf2 [x] = [0, x]
toUtf2 (x:xs) = 1:x:toUtf2 xs

test :: [Int]
test = [1,1, 1,0, 0,1, 1,0, 1,1, 0,0, 1,1, 0,0, 0,0, 0,0]

splitUtf2 :: [Bit] -> [[Bit]]
splitUtf2 bs = chunksOf 2 bs
             & groupUntil (\case [0, _] -> True; _ -> False)
            <&> concatMap (\case [_, x] -> [x]; x -> x)

groupUntil :: (a -> Bool) -> [a] -> [[a]]
groupUntil p xs = foldl' (alg p) [[]] xs <&> reverse & reverse
  where
    alg :: (a -> Bool) -> [[a]] -> a -> [[a]]
    alg _ [] _ = []
    alg p' (hs:ts') x = let ts = (x:hs):ts' in if p' x then []:ts else ts

padLeft :: a -> Int -> [a] -> [a]
padLeft c n xs = replicate (n - length xs) c ++ xs

toByte :: Int -> Word8
toByte = toEnum

fromByte :: Word8 -> Int
fromByte = fromEnum

toBytes :: [Int] -> ByteString
toBytes xs = xs
          <&> toByte
           & pack

fromBytes :: ByteString -> [Int]
fromBytes bs = bs
             & unpack
            <&> fromByte

encode :: String -> ByteString
encode cs = cs
        >>= (toUtf2 . toBin . ord)
          & chunksOf 8
         <&> toDec
          & toBytes

decode :: ByteString -> String
decode bs = bs
          & fromBytes
        >>= toBin
          & splitUtf2
         <&> (chr . toDec)

-- J\n
-- 11101011 10110011 10110000
-- 11101011 10110011 10110000
-- 11101011 10110011 10110000
-- 11101011 10110011 10110000

-- J = 1001010  code point
--     11 10 10 11 10 11 00
--     11101011 10110000

-- :%!xxd -b
