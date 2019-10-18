merge :: [Int] -> [Int] -> [Int]
merge arrx []                            = arrx
merge [] arry                            = arry
merge arrx@(x:xs) arry@(y:ys) | (x <= y) = x : merge xs arry
                              | (x > y)  = y : merge arrx ys

mergeSort :: [Int] -> [Int]
mergeSort []  = []
mergeSort [x] = [x]
mergeSort xs  = merge (mergeSort(take (div (length xs) 2) xs)) (mergeSort(drop (div (length xs) 2) xs))