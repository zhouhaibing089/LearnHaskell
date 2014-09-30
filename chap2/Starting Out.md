Starting OUt
============

##Ready, set, go!

修改提示符

```haskell
:set prompt <prompt>
```

基本的计算器操作

```haskell	
ghci > 2 + 15
17
ghci > 49 * 100
4900
ghci > 1892 - 1472
420
ghci > 5 / 2
2.5
```

你可以用括号来指定计算顺序

```haskell
ghci > (50 * 100) - 4999
1
ghci > 50 * 100 - 4999
1
ghci > 50 * (100 - 4999)
-244950
```

处理负数时你需要加上括号
	
```haskell
ghci > 5 * (-3)
-15
```

布尔值操作	

```haskell
ghci > True && False
False
ghci > True || False
True
ghci > not True
False
```

测试相等性

```haskell
ghci > 5 == 5
True
ghci > 1 == 0
False
ghci > 5 /= 5			-- /= means not equal
False
ghci > 5 /= 4
True
ghci > "Hello" == "Hello"
True
```

当类型不匹配时,解释器会给你提示错误,你不能执行像`5 + "llama"`和`5 == True`这样的运算.

一些函数
	
*	`succ`
*	`min`
*	`max`

可以使用中缀操作符

```haskell
5 `div` 2			-- = 2
```

###第一个函数

```haskell
doubleMe x = x + x
doubleUs x y = x * 2 + y * 2
doubleSmallNumber x = if x > 100 then x else x * 2
doubleSmallNumberPlusOne x = (if x > 100 then x else x * 2) + 1
```

在Haskell中,`else`是必须的

expression就是一串有值的代码(a piece of code that returns a value)

在Haskell中,函数名不能以大写字母开头,当一个函数不接受任何参数时,我们将其称为definition(或者name)

###List概述

List是一个同构(homogenous)的数据结构,它存储相同类型的元素,这就意味着我们可以有一个数值list或者字符list,但不能是一个既含有数值,又含有字符的list.

我们可以使用`let`关键字来在GHCI中定义一个名字.

也就是说我们在GHCI中使用`let a = 1`和在script中写`a = 1`并加载到GHCI中效果是一样的.

```haskell
ghci > let lostNumbers = [4, 8, 15, 16, 23, 48]
ghci > [1, 2, 3, 4] ++ [9, 10, 11, 12]          -- 两个list拼起来
[1, 2, 3, 4, 9, 10, 11, 12]
ghci > "hello, " ++ "world"
"Hello, world"
ghci > 'A' : " SMALL CAT"                       -- 在头部增加一个元素
"A SMALL CAT"
ghci > "Steve Buscemi" !! 6
'B'                                             -- 取出list中某元素
```

`[1, 2, 3]`和`1:2:3:[]`效果是一样的. `[]`定义了一个空list.

取list中元素时要注意不要越界.

当list中的元素可以比较大小的时候,那么list本身也就可以比较大小(`<`,`<=`,`>`,`>=`)

一些关于List的基本函数

`head`: 返回第一个元素

```haskell
ghci > head [5, 4, 3, 2, 1]
5
```

`tail`: 返回第一个元素后的其他元素

```haskell
ghci > tail [5, 4, 3, 2, 1]
[4, 3, 2, 1]
```

`last`: 返回最后一个元素

```haskell
ghci > last [5, 4, 3, 2, 1]
1
```

`init`: 返回最后一个元素前的其他元素

```haskell
ghci > init [5, 4, 3, 2, 1]
[5, 4, 3, 2]
```

上面这些函数不能接收`[]`作为参数

`length`: return its length

	ghci > length [5, 4, 3, 2, 1]
	5

`null`: 检查List是否为空

```haskell
ghci > null [1, 2, 3]
False
ghci > null []
True
```

`reverse`: 将list中元素位置反转

```haskell
ghci > reverse [5, 4, 3, 2, 1]
[1, 2, 3, 4, 5]
```

`take`: 从list头部取出指定数目个元素

```haskell
ghci > take 3 [5, 4, 3, 2, 1]
[5, 4, 3]
ghci > take 1 [3, 9, 3]
[3]
ghci > take 5 [1, 2]	// if the number is more than length, return the list itself
[1, 2]
ghci > take 0 [6, 6, 6]
[]
```

`drop`: 从list尾部取出指定数目个元素

```haskell
ghci > drop 3 [8, 4, 2, 1, 5, 6]
[1, 5, 6]
ghci > drop 0 [1, 2, 3, 4]
[1, 2, 3, 4]
ghci > drop 100 [1, 2, 3, 4]
[]
```

`maximum`: 返回list中最大的那个元素

`minimum`: 返回list中最小的那个元素

`sum`: 返回list中所有元素的和

`product`: 返回list中所有元素的积

```haskell
ghci > sum [5, 2, 1, 6, 3, 2, 5, 7]
31
ghci > product [6, 2, 1, 2]
24
```

`ele`: 检查list中是否含有指定元素,通常以中缀形式出现

###Texas ranges

```haskell
ghci > [1..20]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
ghci > ['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
ghci > ['K'..'Z']
"KLMNOPQRSTUVWXYZ"
```

你也可以指定步长

```haskell
ghci > [2, 4..20]
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
ghci > [3, 6..20]
[3, 6, 9, 12, 15, 18]
```

步长也可以为负数

```haskell
ghci > [20, 19..1]
[20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
```

在浮点数的情况下要格外小心

```haskell
ghci > [0.1, 0.3..1]
[0.1, 0.3, 0.5, 0.7, 0.899999999999, 1.0999999999]
```

所以尽量不要这样使用

你也可以不指定上界来创建一个无穷list

```haskell
ghci > [13, 26..13*24]
take 24 [13, 26..]
```

由于lazy的特性,Haskell并不会马上对无穷list求值

下面是一些常用的函数用来创建无穷(infinite)的list

`cycle`: 

```haskell
ghci > take 10 (cycle [1, 2, 3])
[1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
ghci > take 12 (cycle "LOL ")
"LOL LOL LOL "
```

`repeat`:

```haskell
ghci > take 10 (repeat 5)
[5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
ghci > replicate 3 10 
[10, 10, 10]
```

###List comprehension

下面是一些例子

```haskell
ghci > [x*2 | x <- [1..10]]
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
ghci > [x*2 | x <- [1..10], x*2 >= 12]
[12, 14, 16, 18, 20]
ghci > [x | x <- [50..100], x `mod` 7 == 3]
[52, 59, 66, 73, 80, 87, 94]
ghci > let boomBangs xs = [if x < 10, then "BOOM" else "BANG" | x <- xs, odd x]
ghci > boomBangs [7..13]
["BOOM!", "BOOM!", "BANG!", "BANG!"]
ghci > [x | x <- [10..20], x /= 13, x /= 15, x/=19]
[10, 11, 12, 14, 16, 17, 18, 20]
ghci > [x * y | x <- [2, 5, 10], y <- [8, 10, 11]]
[16, 20, 22, 40, 50, 55, 80, 100, 110]
ghci > [x * y | x <- [2, 5, 10], y <- [8, 10, 11], x * y > 50]
[55, 80, 100, 110]
ghci > let nouns = ["hobo", "frog", "pope"]
ghci > let adjectives = ["lazy", "grouchy", "scheming"]
ghci > [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
["lazy hobo", "lazy frog", "lazy pope", "grouchy hobo", "grouchy frog", "grouchy pope", "scheming hobo", "scheming frog", "scheming pope"]
ghci > let length_m xs = sum [1 | _ <- xs]
ghci > let removeNonUppercase st = [c | c <- st, c `ele` ['A'..'Z']]
ghci > removeNonUppercase "Hahaha ! Ahahaha"
"HA"
ghci > removeNonUppercase "IdontLIKEFOGS"
"ILIKEFOGS"
```

###元组(tuple)

`fst`: 接收一个pair值,并返回第一个值

```haskell
ghci > fst (8, 11)
8
ghci > fst ("WOW", False)
"WOW"
```

`snt`: 接收一个pair值,并返回第二个值

`zip`: 接收两个list,并一一组合产生一个tuple的list

```haskell
ghci > zip [1, 2, 3, 4, 5] [5, 5, 5, 5, 5]
[(1, 5), (2, 5), (3, 5), (4, 5), (5, 5)]
ghci > zip [1, 2, 3, 4, 5] ["one", "two", "three", "four", "five"]
[(1, "one"),...]
```
如果两个list长度不相等,长的list后面的元素会被截断以适应短的list长度,因为lazy的特性,我们zip一个无穷list和一个有穷list

下面是一个结合使用tuple和list的例子

```haskell
let triangle = [(a, b, c) | a<-[1..10], b<-[1..a], c<-[1..c], a^2 + b^2 == c^2]
```
