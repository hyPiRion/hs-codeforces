import Control.Monad (liftM, unless, when)
import Data.List (group, intercalate, sort)
import Prelude hiding (reads)

reads :: Read a => IO [a]
reads  =  liftM (map read . words) getLine

solve :: [Int] -> [Int]
solve xs  =   concat
    [[last xs'], init (tail xs'), [head xs']]
  where
    xs'  =  sort xs

prints :: Show a => [a] -> IO ()
prints  =  putStrLn . intercalate " " . map show

main :: IO ()
main  =  getLine >> reads >>= prints . solve
