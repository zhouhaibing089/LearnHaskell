Modules
=======

### Making our own modules

```haskell
module Geometry             -- module name
(sphereVolume               -- exported functions
, sphereArea
) where

sphereVolumn :: Float -> Float
sphereVolumn radius = (4.0 / 3.0) * pi * (radius ^ 3)

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)
```

上面这个例子还是比较清楚地描述了如何定义自己的module,如果你需要定义sub module,比如说你希望Geometry Module中定义子module.

那么你需要建立一个文件夹,在文件夹里的子文件就代表一个Module.
