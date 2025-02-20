{-# LANGUAGE MultilineStrings #-}

module Main where

import System.Environment (getArgs)
import System.IO (getContents)
import qualified Data.ByteString as B
import Encode (encode)

usage :: String
usage =
    """
    Usage: utf2 (--encode | --decode) <fpath>
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
        --["--decode"] -> do
            --input <- getContents
            --B.putStr $ encode input
        _ -> putStrLn usage
