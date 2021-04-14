module Main where

import           Control.Exception
import           Lib

main = do
  file <- readFile "sample-data/system2.txt"
  let equations = map toNumbers $ lines file
  
  catch (print $ getSolution equations) handler
  where
    handler :: SomeException -> IO ()
    handler ex = putStrLn "The equation has no solutions!"
