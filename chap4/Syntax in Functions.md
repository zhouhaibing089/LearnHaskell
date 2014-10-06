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

`(a,_)`匹配长度大于1的任何list

```haskell
capital :: String -> String
capital "" = "Empty string, whoops"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
```

所以也就意味着`@`符号前可以保留原始值的引用

###Guards, guards

Pattern是一种确认值符合某种形式,并将其分解,而Guards是一种检测某个值是否拥有某属性的方式.

```haskell
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You are underweight, you emo, you!"
    | bmi <= 25.0 = "You are supposedly normal, Pffft, I bet you are ugly!"
    | bmi <= 30.0 = "You are fat! Lose some weight, fatty!"
    | otherwise = "You are a whale, congratulations!"
```

Guards基本来说就是一个布尔值,如果这个布尔值为`True`,那么对应的函数体便会执行,如果这个布尔值为`False`,那么会进行一个检查.

通常最后一个guard是`otherwise`,它总是返回`True`.

当所有的guards都检查过,并且都为False,那么会执行到下一个pattern,这便是guards和pattern之间的关系

```haskell
bmiTell :: (RealFloat a) => a -> a ->String
bmiTell weight height
    | weight / height ^ 2 <= 18.5 = "You are underweight, you emo, you!"
    | weight / height ^ 2 <= 25.0 = "You are supposedly normal. Pffft, I bet you are ugly!"
    | weight / height ^ 2 <= 30.0 = "You are fat, Lose some weight, fatty"
    | otherwise = "You are a whale, congratulations!"
```

###Where

我们上面这段代码重复计算了三遍`weight / height ^ 2`,这不是我们希望看到的.

```haskell
bmiTell :: (RealFloat a) => a -> a ->String
bmiTell weight height
    | bmi <= 18.5 = "You are underweight, you emo, you!"
    | bmi <= 25.0 = "You are supposedly normal. Pffft, I bet you are ugly!"
    | bmi <= 30.0 = "You are fat, Lose some weight, fatty"
    | otherwise = "You are a whale, congratulations!"
    where bmi = weight / height ^ 2
```

即通过在where中将计算出来的值赋值给`bmi`变量来做到只需计算一次.

通常的做法是我们在guards后写上where,且在where中定义的名称在guards中都是可见的.

当在where处声明了多个名称(name)时,最好对齐

where并不在pattern中共享变量

在where中也可以使用pattern match

```haskell
where   bmi = weight / height ^ 2
        (skinny, normal, fat) = (18.5, 25.0, 30.0)
```

另外一个函数

```haskell
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where   (f:_) = firstname
            (l:_) = lastname
```

就像我们可以在where中定义常量一样,我们也可以在其中定义函数

```haskell
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2
```

这里我们引入`bmi`作为一个函数

where是可以嵌套的.

###Let it be

```haskell
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^ 2
    in sideArea + 2 * topArea
```

所以你可以看到形式是这个样子:`let <bindings> in <expression>`,你在let中定义的变量只可在in中看到.

let和where的区别在于let本身是一个expression,而where是构成expression的一部分.

```haskell
ghci > [if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" elsee "Bar"]
["Woo", "Bar"]
ghci > 4 * (let a = 9 in a + 1) + 2
42
ghci > (let a = 100; b = 100; c = 300 in a * b * c, let foo = "Hey "; bar = "there!" in foo ++ bar)
(6000000, "Hey there!")
```

你不必在每一个binding之后都加上分号,但是你想加上的话也是可以的.让我们看看let binding怎么和pattern match结合起来.

```haskell
ghci > (let (a, b, c) = (1, 2, 3) in a + b + c) * 100
600
```

你也可以将let binding放在list comprehensions中.

```haskell
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
```

在上面我们省略了in部分,因为在这里bmi的可见性已经被先指定了.

let和where的区别还是在于scope上.let不能用在guards中...

###Case expressions

接收到一个值,对其使用pattern match,然后决定执行哪段代码.

下面这两段代码是等价的.

```haskell
headTwo :: [a] -> a
headTwo [] = error "No head for empty lists!"
headTwo (x:_) = x
```

另外一段使用case expression等价代码

```haskell
headTwo :: [a] -> a
headTwo xs = case xs of [] -> error "No head for empty lists!"
                        (x:_) -> x
```

case expression的form还是比较清楚的.

```haskell
case expression of  pattern -> result
                    pattern -> result
                    pattern -> result
                    ...
```
