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

### Only folds and horses

`foldl`函数: 将一个list从左向右fold出一个值

```haskell
suma :: (Num a) => [a] -> a
suma xs = foldl (\acc x -> acc + x) 0 xs    -- which is the same as suma = foldl (+) 0

elema :: (Eq a) => a -> [a] -> Bool
elema y ys = foldl (\acc x -> if y == x then True else acc) False ys
```

通常来说,如果你有个函数类似于`foo a = bar b a`,那么你可以写成`foo = bar a`.

`foldr`函数: 将一个list从右向左fold出一个值,它与`foldl`还有一个不同的地方在于接收的参数位置需要呼唤一下,下面的例子将会反映这一点.

```haskell
mapa :: (a -> b) -> [a] - > [b]
mapa f xs = foldr (\x acc -> f x : acc) [] xs
-- the statement is the same as: mapa f xs = foldl (\acc x -> acc ++ [f x]) [] xs
```

**用`foldl`和`foldr`来实现`sum`函数差不多,但还是有点区别,其中之一就是`foldr`可以用于无穷list,但是`foldl`却不可以.**

> folds can be used to implement any functin where you traverse a list once, element by element, and the nreturn something based on that. Whenever you want to traverse a list and return something, chances are you want a fold.

`foldl1`和`foldr1`与上面两个函数的区别在于他们以list中的值作为初始值. 也正因为此,他们不能作用在一个空的list上.

下面是一些例子,他们使用fold来实现:

```haskell
maximuma :: ( Ord a ) = > [ a ] -> a
maximuma = foldr1 (\ x acc -> if x > acc then x else acc )
reversea :: [ a ] -> [ a ]
reversea = foldl (\ acc x -> x : acc ) [] -- which is the same as foldl (flip (:)) []
producta :: ( Num a ) = > [ a ] -> a
producta = foldr1 (*)
filtera :: ( a -> Bool ) -> [ a ] -> [ a ]
filtera p = foldr (\ x acc -> if p x then x : acc else acc ) []
heada :: [ a ] -> a
heada = foldr1 (\ x _ -> x )
lasta :: [ a ] -> a
lasta = foldl1 (\ _ x -> x )
```

`head`和`last`最好还是通过pattern match来实现.

另外一种描述`foldl`和`foldr`的方式是:

> 假如我们`foldr f z [3, 4, 5, 6]`,那么其实我们做的事情是`f 3 (f 4 (f 5 (f 6 z)))`
> 
> 假如我们`foldl g z [3, 4, 5, 6]`,那么其实我们做的事情是`g (g (g (z 3) 4) 5) 6`

`scanl`和`scanr`与`foldl`和`foldr`很类似.

```haskell
ghci > scanl (+) 0 [3, 5, 2, 1]
[0, 3, 8, 10, 11]
ghci > scanr (+) 0 [3, 5, 2, 1]
[11, 10, 8, 3, 0]
ghci > scanl1 (\acc x -> if x > acc then x else acc) [3, 4, 5, 3, 7, 9, 2, 1]
[3, 4, 5, 5, 7, 9, 9, 9]
ghci > scanl (flip (:)) [] [3, 2, 1]
[[], [3], [2, 3], [1, 2, 3]]
```

当你使用`scanl`时,最终的结果是最后一个元素,当你使用`scanr`时,最终的结果是第一个元素.

`scanl`和`scanr`函数通常用来显示用`fold`函数执行的过程,来看下面这个例子:

```haskell
sqrtSums :: Int
sqrtSums = length (takeWhile (< 1000) (scanl1 (+) (map sqrt [1..])))
```

### Function application with $

`$`是一个函数,也被称为`function application`

```haskell
($) :: (a -> b) -> a -> b
f $ x = f x
```

因为`$`的优先级最低,也是右结合(right associative),所以我们看看它带来了哪些方便

```haskell
sum (map sqrt [1..130])
-- is the same as sum $ map sqrt [1..130]
sqrt (3 + 4 + 9)
-- is the same as sqrt $ 3 + 4 + 9
sum (filter (>10) (map (*2) [2..10]))
-- is the same as sum $ filter (> 10) $ map (*2) [2..10]
```

因为$是right associative的,所以`f (g (z x))`和`g $ g $ z x`是等价的.

```haskell
ghci > map ($ 3) [(4+), (*10), (^2), sqrt]
[7.0, 30.0, 9.0, 1.7320508075688772]
```

### Function Composition

在haskell中,我们使用`.`函数来组合函数,它的定义如下:

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)
```

通过上面这个定义我们可以知道`negate . (*3)`返回一个函数,它接收一个参数,将其乘以3,再对其取反.

```haskell
ghci > map (\x -> negate (abs x)) [5, -3, -6, -7, -3, 2, -19, 24]
[-5, -3, -6, -7, -3, -2, -19, -24]
-- is the same as map (negate . abs) [5, -3, -6, -7, -3, 2, -19, 24]
```

函数的组合是右结合的.所以我们可以一次组合多个函数,`f (g (z x))`和`(f . g. z) x`是等价的.

```haskell
ghci > map (\xs -> negate (sum (tail xs))) [[1..5], [3..6], [1..7]]
[-14, -15, -27]
-- is the same as map (negate . sum .tail) [[1..5], [3..6], [1..7]]
```

如果函数接收多个参数怎么办呢,这个时候想到curry特性,在haskell中,任何一个函数本质上都只接收一个参数(不知这样讲对不对).

**Point free style**

```haskell
suma :: (Num a) => [a] -> a
suma xs = foldl (+) 0 xs
-- in point free style, it is the same as suma = foldl (+) 0
```

但是像下面这种情况就比较复杂了:

```haskell
fn x = ceiling (negate (tan (cos (max 50 x))))
-- it is the same as fn = ceiling . negate . tan . cos . max 50
```

写太长的函数链通常不推荐.

```haskell
-- normal
oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))
-- function composition
oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) .filter odd . map (^2) $ [1..]
-- more readable
oddSquareSum :: Integer
oddSquareSum = 
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in sum belowLimit
```
