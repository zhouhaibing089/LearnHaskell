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
```

Haskell表达式

	doubleSmallNumber x = if x > 100
					then x
					else x * 2

Notice: the else part is mandatory in Haskell

In haskell, every expression and function must return something.

An expression is basically a piece of code that returns a value

In haskell, lists are a homogenous data structure. It stores several elements of the same type. That means that we can have a list of integers or a list of characters but we can not have a list that has a few integers and then a few characters.

Use let keyword to define a name right in GHCI.
Doing `let a = 1` inside ghci is the equivalent of writing a = 1 in a script and then loading it.

##An intro to lists

	let lostNumbers = [4, 8, 15, 16, 23, 48]

Lists are denoted by square brackets and the value in the lists are seperated by commas.

Put two lists together, this is done by using the ++ operator

	ghci > [1, 2, 3, 4] ++ [9, 10, 11, 12]
	[1, 2, 3, 4, 9, 10, 11, 12]
	ghci > "hello, " ++ "world"
	"Hello, world"

Putting something at the beginning of a list using the : operator

	ghci > 'A' : " SMALL CAT"
	"A SMALL CAT"

`[1, 2, 3]` is actually syntactic sugar for `1:2:3:[]`. `[]` is an empty list.

`[]`,`[[]]`, `[[], [], []]` are all different things, the first one is am empty list, the second one is a list that contains one empty list, the third one is a list that contains three empty lists.

`!!` get an element out of a list, the indices start at 0

	ghci > "Steve Buscemi" !! 6 
	'B'
	ghci > [9.4, 33.2, 96.2, 11.2, 23.25] !! 1
	33.2

You can not get element which is out of range

List can be compared if the stuff they contain can be compared. when  using `<`, `<=`, `>`, `>=` to compare lists, they are compared in lexicographical order.

Here are some basic functions that operate on lists

`head`: return its head
	
	ghci > head [5, 4, 3, 2, 1]
	5

`tail`: return its tail

	ghci > tail [5, 4, 3, 2, 1]
	[4, 3, 2, 1]

`last`: return its last element

	ghci > last [5, 4, 3, 2, 1]
	1

`init`: returns everything except last element

	ghci > init [5, 4, 3, 2, 1]
	[5, 4, 3, 2]

the functions above can not take an empty list

`length`: return its length

	ghci > length [5, 4, 3, 2, 1]
	5

`null`: check if a list is empty

	ghci > null [1, 2, 3]
	False
	ghci > null []
	True

`reverse`: reverses a list

	ghci > reverse [5, 4, 3, 2, 1]
	[1, 2, 3, 4, 5]

`take`: takes number and a list, it extracts that many elements from beginning of the list.

	ghci > take 3 [5, 4, 3, 2, 1]
	[5, 4, 3]
	ghci > take 1 [3, 9, 3]
	[3]
	ghci > take 5 [1, 2]	// if the number is more than length, return the list itself
	[1, 2]
	ghci > take 0 [6, 6, 6]
	[]

`drop`: works in a similar way, only it drops the number of elements from the beginning of a list

	ghci > drop 3 [8, 4, 2, 1, 5, 6]
	[1, 5, 6]
	ghci > drop 0 [1, 2, 3, 4]
	[1, 2, 3, 4]
	ghci > drop 100 [1, 2, 3, 4]
	[]

`maximum`: return the biggest element

`minimum`: return the smallest element

`sum`: return the sum of all element

`product`: return the product of all element

	ghci > sum [5, 2, 1, 6, 3, 2, 5, 7]
	31
	ghci > product [6, 2, 1, 2]
	24

`ele`: takes a thing and a list of things and tells us if that thing is an element of that list. usually use an infix way

##Texas ranges

	ghci > [1..20]
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

	ghci > ['a'..'z']
	"abcdefghijklmnopqrstuvwxyz"

	ghci > ['K'..'Z']
	"KLMNOPQRSTUVWXYZ"

You can also specify a step

	ghci > [2, 4..20]
	[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
	ghci > [3, 6..20]
	[3, 6, 9, 12, 15, 18]

Step can also be -1

	ghci > [20, 19..1]
	[20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

Watch out when using floating point numbers in ranges

	ghci > [0.1, 0.3..1]
	[0.1, 0.3, 0.5, 0.7, 0.899999999999, 1.0999999999]

Not use them in list ranges

You can also use ranges to make infinite lists by just not specifying an upper list.

Let's examine how you could get the first 24 multiples of 13.

	ghci > [13, 26..13*24]

there is a better way:
	
	take 24 [13, 26..]

Because haskell is lazy, it won't try to evaluate the infinite list immediately.

A handful of functions that produce infinite lists:

`cycle`: 
	
	ghci > take 10 (cycle [1, 2, 3])
	[1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
	ghci > take 12 (cycle "LOL ")
	"LOL LOL LOL "

`repeat`: take an element and produces an infinite list of just that element

	ghci > take 10 (repeat 5)
	[5, 5, 5, 5, 5, 5, 5, 5, 5, 5]

`replicate 3 10` will return `[10, 10, 10]`

##List comprehension

List comprehension are very similar to set comprehension. We could use:

	ghci > [x*2 | x <- [1..10]]
	[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

You can specify a predicate

	ghci > [x*2 | x <- [1..10], x*2 >= 12]
	[12, 14, 16, 18, 20]

How about if we wanted all numbers from 50 to 100 whose remainder when divided with the number 7 is 3

	ghci > [x | x <- [50..100], x `mod` 7 == 3]
	[52, 59, 66, 73, 80, 87, 94]

Weeding out lists by predicates is also called filtering.

Let's say we want a comprehension that replaces each odd number greater than 10 with "BANG", and each odd number that's less than 10 with "BOOM!"

if a number is not odd, we throw it out of our list.

	boomBangs xs = [if x < 10, then "BOOM" else "BANG" | x <- xs, odd x]

The function odd returns True on an odd number and False on an even one.
The element is included in the list only if all the predicates evaluate to True.

	ghci > boomBangs [7..13]
	["BOOM!", "BOOM!", "BANG!", "BANG!"]

If we wanted all numbers from 10 to 20 that are not 13, 15 or 19.

	ghci > [x | x <- [10..20], x /= 13, x /= 15, x/=19]
	[10, 11, 12, 14, 16, 17, 18, 20]

Not can we have multiple predicates in list comprehensions(an element must satisfy all the predicates to be included in the resulting list).

We can also draw from several lists. When drawing from several lists, comprehensions produce all combinations of the given lists and then 
join them by the output function we supply.

	ghci > [x * y | x <- [2, 5, 10], y <- [8, 10, 11]]
	[16, 20, 22, 40, 50, 55, 80, 100, 110]

	ghci > [x * y | x <- [2, 5, 10], y <- [8, 10, 11], x * y > 50]
	[55, 80, 100, 110]

How about a list comprehension that combines a list of adjectives and a list of nouns..

	ghci > let nouns = ["hobo", "frog", "pope"]
	ghci > let adjectives = ["lazy", "grouchy", "scheming"]
	ghci > [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
	["lazy hobo", "lazy frog", "lazy pope", "grouchy hobo", "grouchy frog", "grouchy pope", "scheming hobo", "scheming frog", "scheming pope"]

We can define lengh function use our version

	length' xs = sum [1 | _ <- xs]

_ means that we do not care what we'll draw from the list anyway so instead of writing a variable name that we'll never use, we just write _
This function replaces every element of a list with 1 and then sums that up. This means that the resulting sum will be the length of our list.

Because strings are lists, we can use list comprehensions to process and produce strings.

	ghci > let removeNonUppercase st = [c | c <- st, c `ele` ['A'..'Z']]
	ghci > removeNonUppercase "Hahaha ! Ahahaha"
	"HA"
	ghci > removeNonUppercase "IdontLIKEFOGS"
	"ILIKEFOGS"

##Tuples

They are a way to store several values into a single value.

Tuples can be compared with each other if their components can be compared.

`fst`: takes a pair and returns its first component.

	ghci > fst (8, 11)
	8
	ghci > fst ("WOW", False)
	"WOW"

`snt`: takes a pair and returns its second component

`zip`: take two lists and then zips them together into one list by joining the matching elements into pairs.

	ghci > zip [1, 2, 3, 4, 5] [5, 5, 5, 5, 5]
	[(1, 5), (2, 5), (3, 5), (4, 5), (5, 5)]
	ghci > zip [1, 2, 3, 4, 5] ["one", "two", "three", "four", "five"]
	[(1, "one"),...]

if the two lists do not have the same length, the longer list simply cut off to match the length of the shorter one, since haskell is lazy, we can zip finite lists with infinite lists

Combination of list and tuples

	let triangle = [(a, b, c) | a<-[1..10], b<-[1..a], c<-[1..c], a^2 + b^2 == c^2]


