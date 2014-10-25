High Order Functions
====================

### Curried functions

大概意思就是说当一个函数接收到的参数不足时,返回的是一个Partial Function.

```haskell
ghci > max 4 5
5
ghci > let maxp = max 4
ghci > :t maxp
maxp :: (Ord a, Num a) => a -> a
```

这也是为何使用`->`的原因.

### Some higher-orderism is in order

函数可以接收函数作为参数也可以将函数作为返回值.

```haskell
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWitha :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWitha _ _ [] = []
zipWitha _ [] _ = []
zipWitha f (x:xs) (y:ys) = (f x y) : zipWitha f xs ys

flipa :: (a -> b -> c) -> (b -> a -> c)
flipa f = g                 -- or flipa f y x = f x y
    where g x y = f y x     
```

`->`符合是右结合性的.

### Map and filters

```haskell
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x : xs)
    | p x = x : filter p xs
    | otherwise filter p xs

-- use filter to implement quick sort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort (filter (<= x) xs)
        biggerSorted = quicksort (filter (> x) xs)
    in smallerSorted ++ [x] ++ biggerSorted

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000, 99999..])
    where p x = x `mod` 3892 == 0
```

### Lambda

Lambda基本上来说就是一个匿名函数,它的形式是:

```haskell
\arg1 arg2 - > funcbody
```

来看下面一些代码.

```haskell
ghci > zipWith (\a b -> (a * 30 + 3) / b) [5, 4, 3, 2, 1] [1, 2, 3, 4, 5]
[150.0, 61.5, 31.0, 15.75, 6.6]
ghci > map (\(a, b) -> a + b) [(1, 2), (3, 5), (6, 3), (2, 6), (2, 5)]
[3, 8, 9, 8, 7]
```

下面是在定义函数时使用lambda的例子.

```haskell
addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z  -- which is the same as addThree = \x -> \y -> \z -> x + y +_ z

flipa :: (a -> b -> c) -> b -> a -> c
flipa f = \x y -> f y x     -- which is the same as flipa f x y = f y x
```


