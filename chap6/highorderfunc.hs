takeWhilea :: (a -> Bool) -> [a] -> [a]
takeWhilea _ [] = []
takeWhilea p (x:xs)
    | p x = x : takeWhilea p xs
    | otherwise = []
