{-# LANGUAGE TemplateHaskell #-}

module Test.Utilities where

import Control.Monad (filterM)
import Data.Function ((&))
import Data.Functor ((<&>))
import Language.Haskell.TH (Exp, Q, runIO)
import System.Directory (listDirectory)
import System.FilePath ((</>))

listDirectorySuchThat :: String -> (String -> IO Bool) -> Q Exp
listDirectorySuchThat dirpath f =
  listDirectory dirpath
    <&> (<&> (dirpath </>))
    >>= filterM f
    & runIO
    >>= (\fps -> [|fps|])
