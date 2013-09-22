import Control.Monad (liftM, unless, when)
import Data.List (group, intercalate, sort)
import Data.Array
import Prelude hiding (reads)

reads :: Read a => IO [a]
reads = liftM (map read . words) getLine

main :: IO ()
main = do
  n <- getLine
  vals <- reads
  putStrLn $ show $ solve (read n) vals

foldla :: (b -> Int -> a -> b) -> b -> Array Int a -> b
foldla f z0 ar = go z0 lo
  where go z i
          | i > hi = z
          | otherwise = go (f z i (ar ! i)) $ i + 1
        (lo, hi) = bounds ar

samePos :: Array Int Int -> Int
samePos a = foldla (\acc idx val -> if idx == val then acc + 1 else acc) 0 a

improvement :: Array Int Int -> Int
improvement perm
  = foldla (\best idx val -> if idx == val then best
                             else if perm ! val == idx then 2
                                  else max 1 best) 0 perm

solve :: Int -> [Int] -> Int
solve n xs = (samePos perm) + (improvement perm)
  where
    dim = (0, n - 1)
    perm = array dim $ zip (range dim) xs
