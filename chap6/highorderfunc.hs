takeWhilea :: (a -> Bool) -> [a] -> [a]
takeWhilea _ [] = []
takeWhilea p (x:xs)
    | p x = x : takeWhilea p xs
    | otherwise = []

suma :: (Num a) => [a] -> a
suma xs = foldl (\acc x -> acc + x) 0 xs

