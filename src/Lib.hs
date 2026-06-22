module Lib
  ( someFunc,
  )
where

import Utilities.Unsafe (todo)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

xxx = todo "hello"
