{-# LANGUAGE MultilineStrings #-}

module Main where

import System.Environment (getArgs)
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
        ["--encode", path] -> B.putStr $ encode path
        ["--decode", path]  -> B.putStr $ encode path
        _ -> putStrLn usage
