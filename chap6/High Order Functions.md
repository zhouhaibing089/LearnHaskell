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
