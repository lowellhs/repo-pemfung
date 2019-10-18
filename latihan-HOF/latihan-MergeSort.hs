merge :: [Int] -> [Int] -> [Int]
merge arrx@(x:xs) arry@(y:ys) | (x <= y) = x : merge xs arry
                              | (x > y)  = y : merge arrx ys