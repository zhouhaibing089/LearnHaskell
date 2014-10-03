bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You are underweight, you emo, you!"
    | bmi <= 25.0 = "You are supposedly normal, Pffft, I bet you are ugly!"
    | bmi <= 30.0 = "You are fat! Lose some weight, fatty!"
    | otherwise = "You are a whale, congratulations!"

bmiTell2 :: (RealFloat a) => a -> a ->String
bmiTell2 weight height
    | weight / height ^ 2 <= 18.5 = "You are underweight, you emo, you!"
    | weight / height ^ 2 <= 25.0 = "You are supposedly normal. Pffft, I bet you are ugly!"
    | weight / height ^ 2 <= 30.0 = "You are fat, Lose some weight, fatty"
    | otherwise = "You are a whale, congratulations!"

max2 :: (Ord a) => a -> a -> a
max2 a b
    | a > b = a
    | otherwise = b

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b = GT
    | a == b = EQ
    | otherwise = LT
