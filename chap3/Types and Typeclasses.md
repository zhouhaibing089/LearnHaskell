###Believe the type

Use `:t expression` to see the type of given expression

The output is `expression :: Type`

the `::` can be read as "has type of"

**Function**也有类型

    addThree :: Int -> Int -> Int -> Int
    addThree x y z = x + y + z

**常见类型**

*   Int: 有界的
*   Integer: 无界的，可以表示任意大的数，但是Int效率更高些
*   Float: 单精度浮点数
*   Double: 双精度浮点数
*   Bool: True和False两个值
*   Char: 单引号括起来
*   The empty tuple is also a type which can only have a single value: ()

###类型变量

当我们查看`head`函数的类型时，我们发现结果是`head :: [a] -> a`

在上面这个例子中a并不真实代表一种类型，它是一个类型变量(type variable)

###Typeclasses

当我们查看`==`的函数类型时，我们发现结果是`(==) :: (Eq a) => a -> a -> Bool`

在`=>`之前的内容都被成为`class constraint`，上面这段输出可以这么读: `==`函数接受两个具有相同类型的变量作为参数，并且返回一个布尔类型结果， The type of those two values must be a member of the `Eq` class.

所有的标准Haskell类型(除了IO相关和函数)都是Eq类型类(Eq typeclass)的一部分

**一些基本的typeclasses**

`Eq`, `Ord`, `Ordering`(LT, GT, EQ), `Show`(相当于具有toString()方法), `Read`

当Read出现歧义的时候，可以使用下面这个解决方案

    ghci> read "5" :: Int

就像我们之前所说的`::`应该被念成`has type of`

`Enum`, `Bounded`(具有上界和下界, 对于Tuple而言，如果其中的子类型是Bounded的话，那么这个Tuple也是Bounded的一个成员)

`Num`: 

我们可以检查一下乘法的类型

    ghci> :t (*)
    (*) :: (Num a) => a -> a -> a

因为乘法需要接受两个相同类型的参数，因此`(5 :: Int) * (6 :: Integer)`会产生类型错误

`Integral`: (Int和Integer)

`Floating`: (Float和Double)

`fromIntegral`是用来将Integral转成Num的这样的话下面这行代码才不会报类型错误异常

    ghci> fromIntegral (length [1, 2, 3, 4]) + 3.2
    ghci> 7.2
    ghci> :t fromIntegral
    fromIntegral :: (Num b, Integral a) => a -> b


