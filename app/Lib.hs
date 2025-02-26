{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Lib where

import Data.Functor
import Data.Function
import Data.Char (ord, chr)
import Data.List.Split (chunksOf)
import Data.Word (Word8)
import Data.ByteString (ByteString)
import qualified Data.ByteString as B

type Bit = Int

toBin :: Int -> [Bit]
toBin 0 = [0]
toBin x = reverse $ bin x
  where
    bin :: Int -> [Bit]
    bin 0 = []
    bin n = let (q,r) = n `divMod` 2 in r : bin q

toDec :: [Bit] -> Int
toDec xs = sum $ zipWith (*) powOf2 (reverse xs)
  where powOf2 = [2^x | x <- ([0..] :: [Int])]

toUtf2 :: [Bit] -> [Bit]
toUtf2 [] = []
toUtf2 [x] = [0, x]
toUtf2 (x:xs) = 1:x:toUtf2 xs

splitUtf2 :: [Bit] -> [[Bit]]
splitUtf2 bs = chunksOf 2 bs
             & groupUntil (\case [0, _] -> True; _ -> False)
            <&> concatMap (\case [_, x] -> [x]; _ -> [])

groupUntil :: (a -> Bool) -> [a] -> [[a]]
groupUntil p xs =
  let
    alg :: (a -> Bool) -> [[a]] -> a -> [[a]]
    alg _ [] _ = []
    alg p' (h:ts') x = let ts = (x:h):ts' in if p' x then []:ts else ts
  in foldl' (alg p) [[]] xs & pop null <&> reverse & reverse

pop :: (a -> Bool) -> [a] -> [a]
pop _ [] = []
pop p xs@(h:ts)
  | p h = ts
  | otherwise = xs

padLeft :: a -> Int -> [a] -> [a]
padLeft c n xs = replicate (n - length xs) c ++ xs

toByte :: Int -> Word8
toByte = toEnum

fromByte :: Word8 -> Int
fromByte = fromEnum

toBytes :: [Int] -> ByteString
toBytes xs = xs
          <&> toByte
           & B.pack

fromBytes :: ByteString -> [Int]
fromBytes bs = bs
             & B.unpack
            <&> fromByte

preEncode :: [Bit] -> [Bit]
preEncode bs =
  (++bs) $ case length bs `mod` 8 of
    0 -> [1, 1, 0, 0, 0, 0, 0, 0]
    2 -> [1, 0, 0, 0, 0, 0]
    4 -> [0, 1, 0, 0]
    6 -> [0, 0]
    _ -> []

preDecode :: [Bit] -> [Bit]
preDecode (1:1:0:0:0:0:0:0:bs) = bs
preDecode (1:0:0:0:0:0:bs) = bs
preDecode (0:1:0:0:bs) = bs
preDecode (0:0:bs) = bs
preDecode bs = bs

encode :: String -> ByteString
encode "" = ""
encode cs = cs
        >>= (toUtf2 . toBin . ord)
          & chunksOf 8 . preEncode
         <&> toDec
          & toBytes

decode :: ByteString -> String
decode "" = ""
decode bs = bs
          & fromBytes
        >>=  padLeft 0 8 . toBin
          & splitUtf2 . preDecode
         <&> (chr . toDec)


-- ab 1100001 1100010 1010
-- 11111010101001 11111010101100 11101100
--
-- 01001111 10101010 01111110 10101100 11101100  EXPECTED
-- 01001111 10101010 01111110 10101100 11101100  ACTUAL
