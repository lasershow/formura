module Main where

import Control.Applicative
import Control.Lens
import Control.Monad
import Data.Monoid
import qualified Data.Text.IO as T
import qualified Data.Set as S
import System.Environment
import System.IO
import Text.Trifecta
import Text.Printf
import Text.PrettyPrint.ANSI.Leijen as Pretty hiding (line, (<>), (<$>), empty, integer)

import Language.Formura.Parser
import Language.Formura.Enforest



main :: IO ()
main = do
  (fileName:_ ) <- getArgs
  res <- parseFromFileEx (internalP program <* eof) fileName
  case res of
    Success ast -> do
      putStrLn "#### Tokenized Program ####"
      print ast
      putStrLn "#### Enforest Mk. 1 ####"
      mapM_ print $ readProgram ast
      putStrLn "#### Enforest Mk. 2 ####"
      mapM_ print $ readProgram2 ast
    Failure doc -> displayIO stdout $ renderPretty 0.8 80 $ doc <> linebreak
