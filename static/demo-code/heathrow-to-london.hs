module Main  where


data Side = LEFT | RIGHT


f :: Side -> [Int] -> Int
f LEFT  (l : m : r : []) = min l (m + r)
f RIGHT (l : m : r : []) = min r (m + l)
f LEFT  (l : m : r : xs) = min (l + f LEFT xs) (m + r + f RIGHT xs)
f RIGHT (l : m : r : xs) = min (r + f RIGHT xs) (m + l + f LEFT xs)

main :: IO ()
main =
  putStrLn $ show $ f LEFT [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8]

