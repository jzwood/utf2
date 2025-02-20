module Main where

import qualified Data.ByteString as B
import Encode (encode)

main :: IO ()
main = B.putStr $ encode "J"


--import System.Environment (getArgs)
--main :: IO ()
--main = do
    --args <- getArgs
    --case args of
        --[filePath] -> do
            --content <- readFile filePath
            ---- Process the content
        --_ -> putStrLn "Usage: utf2 [--encode | --decode] <filePath>"
