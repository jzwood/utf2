{-# LANGUAGE MultilineStrings #-}

module Main where

import System.Environment (getArgs)
import qualified Data.ByteString as B
import Lib (encode, decode)

usage :: String
usage =
    """
    Usage: utf2 (--encode | --decode) < inputFile > outputFile
    Options:
      --encode     converts utf8 data to utf2
      --decode     converts utf2 data to utf8
    """

main :: IO ()
main = do
    args <- getArgs
    case args of
        ["--encode"] -> do
            input <- getContents
            B.putStr $ encode input
        ["--decode"] -> do
            input <- B.getContents
            putStr $ decode input
        _ -> putStrLn usage
