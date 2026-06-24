{-# LANGUAGE TemplateHaskell #-}

module Test.Lib (spec) where

import Control.Lens ((^.))
import Data.Functor ((<&>))
import Data.List qualified as List
import Data.Text.Lazy.Encoding qualified as TL
import Data.Text.Lazy.IO qualified as TLIO
import Lib (greet)
import System.FilePath ((</>))
import System.FilePath.Lens (basename)
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.Golden (goldenVsString)
import Test.Utilities (listDirectorySuchThat)

spec :: TestTree
spec = do
  testGroup "Lib" . concat $
    [ $(listDirectorySuchThat ("asset" </> "example") (return . (".input.txt" `List.isSuffixOf`)))
        <&> ( \inputFilepath ->
                goldenVsString (inputFilepath ^. basename) (inputFilepath <> ".output.txt") $ do
                  input <- TLIO.readFile inputFilepath
                  let output = greet input
                  return . TL.encodeUtf8 $ output
            )
    ]
