Recursion
=========

假如说我们希望找到list中最大的那个元素,下面是递归的做法.

```haskell
maximuma :: (Ord a) => [a] -> a
maximuma [] = error "maximum of empty list"
maximuma [x] = x
maximuma (x:xs)
    | x > maxtail = x
    | otherwise = maxtail
    where maxtail = maximuma xs
```

我们可以借用`max`函数来使上面那段代码更加整洁.

```haskell
maximuma :: (Ord a) => [a] -> a
maximuma [] = error "maximum of empty list"
maximuma [a] = x
maximuma (x:xs) = max x (maximuma xs)
```

更多例子:

```haskell
replicatea :: (Num i, Ord i) => i -> a -> [a]
replicatea n x
    | n <= 0 = []
    | otherwise = x:replicatea (n - 1) x
    
takea :: (Num i, Ord i) => i -> [a] -> [a]
takea n _
    | n <= 0 = []
takea _ [] = []
takea n (x:xs) = x : takea (n - 1) xs

reversea :: [a] -> [a]
reversea [] = []

repeata :: a -> [a]
repeata x = x : repeata x

zipa :: [a] -> [b] -> [(a, b)]
zipa _ [] = []
zipa [] _ = []
zipa (x:xs) (y:ys) = (x, y):zipa xs ys

elema :: (Eq a) => a -> [a] -> Bool
elema a [] = False
elema a (x:xs)
    | a == x = True
    | otherwise = a `elema` xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSortedreversea (x:xs) = reversea xs ++ [x]
```

上面的函数声明中为i定义了两个约束(Ord和Num,因为Num并不是Ord的子类)
