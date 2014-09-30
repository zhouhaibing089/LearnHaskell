Syntax in Functions
===================

###Pattern matching

以下是一小段函数代码

```haskell
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"
sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"
```

Pattern match从上至下进行匹配

两种`addVectors`的实现

```haskell
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)
```

另外一种实现

```haskell
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
```

我们针对triple也可以写`fst`函数和`snd`函数

```haskell
first :: (a, b, c) -> a
first (x, _, _) = x
second :: (a, b, c) -> b
second (_, y, _) = y
third :: (a, b, c) -> c
third (_, _, z) = z
```

事实上,你也可以在list comprehensions中使用pattern match

```haskell
ghci > let xs = [(1, 3), (4, 3), (2, 4), (5, 3), (5, 6), (3, 1)]
ghci > [a + b | (a, b) <- xs]
[4, 7, 6, 8, 11, 4]
```
