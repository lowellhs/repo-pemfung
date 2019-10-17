Latihan HOF
=============

Akan dibahas latihan yang terdiri dari :<br />
**- Latihan High-order function**<br />
**- Latihan list comprehension dan lazy evaluation**
<br />
<br />

## Latihan High-order function ##
**Define the length function using map and sum.**
~~~
arrLength :: [a] -> Int
arrLength arr = sum(map (\x -> 1) arr)
~~~
<br />

**What does `map (+1) (map (+1) xs)` do? Can you conclude anything in general about properties of `map f (map g xs)`, where `f` and `g` are arbitrary functions?**
~~~
Ekspresi map (+1) (map (+1) xs), pertama — tama menambahkan 1 
terhadap setiap elemen dalam list xs. Kemudian, ditambahkan 
lagi terhadap setiap elemen sebesar 1. Ini seperti fungsi komposisi 
sehingga map f (map g xs) berbentuk seperti f(g(x)) dalam matematika.
~~~
<br />

**Give the type of, and define the function iter so that `iter n f x = f (f (... (f x)))` where f occurs n times on the right-hand side of the equation. For instance, we should have `iter 3 f x = f (f (f x))` and `iter 0 f x` should return `x`.**
~~~
iter :: Int -> (a -> a) -> a -> a
iter 0 f x = x
iter n f x = f(iter (n - 1) f x)
~~~
<br />

**What is the type and effect of the following function? `\n -> iter n succ`**
~~~
Fungsi tersebut merupakan anonymous function sehingga
dapat digunakan seperti, (\n -> iter n succ) 10 20 
Yang sama saja atau ekivalen dengan ekspresi iter 10 succ 20
~~~
<br />

**How would you define the sum of the squares of the  natural numbers 1 to n using `map` and `foldr`?**
~~~
sumSquared n = foldr (+) 0 (map (^2) [1..n])
~~~
<br />

**How does the function**
~~~
mystery xs = foldr (++) [] (map sing xs)  
    where sing x = [x]
~~~
**behave?**
~~~
Misalkan xs = [1,2,3,4,5] maka fungsi tersebut akan 
menghasilkan hasil yang sama dengan xs . Proses fungsi 
tersebut terhadap contoh xs adalah xs terlebih dahulu 
berubah menjadi [[1], [2], [3], [4], [5]] kemudian 
melakukan foldr[1] : ([2] : ([3] : ([4] : ([5] : []))))
~~~
<br />

**If `id` is the polymorphic identity function, defined by  `id x = x`, explain the behavior of the expressions `(id . f)` `(f . id)` `(id f)` If `f` is of type `Int -> Bool`, at what instance of its most  general type `a -> a` is `id` used in each case?**
~~~
Operator titik (.) pada Haskell sama seperti komposisi 
pada notasi matematika sehingga,
f (g x) = (f . g) x
1) (id . f) x   = id (f x)  = f x
2) (f . id) x   = f (id x)  = f (x)     = f x
3) (id f) x     = (f) x     = f x
Terlihat ketiganya menghasilkan hasil yang sama walaupun
evaluasi ekspresi berbeda.
~~~
<br />

**Define a function `composeList` which composes a list of  functions into a single function. You should give the type of `composeList`, and explain why the function has this type. What is the  effect of your function on an empty list of functions?**
~~~
composeList :: [a -> a] -> (a -> a)
Karena fungsi composeList menerima list of fungsi [a -> a] 
dan menghasilkan sebuah fungsi (a -> a)

Pendekatan pertama tanpa fold,
(1) composeList [] = id
(2) composeList (x:xs) = x . composeList xs

Jika dalam bentuk universal didapatkan,
v = id
Kemudian,
composeList (x:xs) = f x (composeList xs)
x . composeList xs = f x (composeList xs)
             x . y = f x y -----> composeList xs = y
didapatkan f = (.)
Sehingga bentuk menggunakan fold adalah,

composeList = foldr (.) id
~~~
<br />

**Define the function `flip :: (a -> b -> c) -> (b -> a -> c)`**
~~~
flip :: (a -> b -> c) -> (b -> a -> c)
flip f a b = f b a
~~~
<br />

**Can you rewrite the following list comprehensions using the higher-order functions map and filter? You might need the function concat too.**
~~~
[ x+1 | x <- xs ]
f1 xs = map (+1) xs

[ x+y | x <- xs, y <-ys ]
f2 xs ys = concat (map (\x -> map (\y -> (x+y)) ys) xs)

[ x+2 | x <- xs, x > 3 ]
f3 xs = map (+2) (filter (>3) xs)

[ x+3 | (x,_) <- xys ]
f4 xys = map (\(x,y) -> x + 3) xys

[ x+4 | (x,y) <- xys, x+y < 5 ]
f5 xys = map (\(x,y) -> x+4) (filter (\(x,y) -> x+y < 5) xys)

[ x+5 | Just x <- mxs ]
f6 mxs = map (\(Just x) -> x+5) mxs
~~~
<br />

**Can you it the other way around? I.e. rewrite the following expressions as list comprehensions.**
~~~
map (+3) xs
f7 xs = [ x+3 | x <- xs ]

filter (>7) xs
f8 xs = [ x | x <- xs, x > 7 ]

concat (map (\x -> map (\y -> (x,y)) ys) xs)
f9 xs ys = [ (x,y) | x <- xs, y <- ys ]

filter (>3) (map (\(x,y) -> x+y) xys)
f10 xys = [ x+y | (x,y) <- xys, x+y > 3 ]
~~~
<br />

## Latihan list comprehension dan lazy evaluation ##

**Uraikan langkah evaluasi dari ekspresi berikut: `[ x+y | x <- [1 .. 4], y <- [2 .. 4], x > y ]`**
~~~
x diambil dari range 1 sampai 4 (inklusif)
y diambil dari range 2 sampai 4 (inklusif)
Setelah itu dilakukan filtering dengan predikat x > y
didapatkan output x + y
~~~
<br />

**Buatlah fungsi divisor yang menerima sebuah bilangan bulat n dan mengembalikan list bilangan bulat positif yang membagi habis n**
~~~
divisor :: Int -> [Int]
divisor n = [ x | x <- [1..n], n `mod` x == 0 ]
~~~
<br />

**Buatlah definisi quick sort menggunakan list comprehension**
~~~
quicksort :: [Int] -> [Int]
quicksort []      = []
quicksort (x:xs)  = (quicksort (filter (<=x) xs)) ++ [x] ++ (quicksort (filter (>x) xs))
~~~
<br />

**Buatlah definisi infinite list untuk permutation**
~~~
perm [] = [[]]
perm ls = [ x:ps | x <- ls, ps <- perm(ls \\ [x])]
~~~
<br />

**Buatlah definisi untuk memberikan infinite list dari bilangan prima menerapkan algoritma Sieve of Erastothenes**
~~~
primes = sieve [2 ..]
  where sieve (x:xs) = x : (sieve [z | z <- xs, z `mod` x /= 0])
~~~
<br />

**Buatlah definisi infinite list dari triple pythagoras. List tersebut terdiri dari element triple bilangan bulat positif yang mengikut persamaan pythagoras**
~~~
pythaTriple = [(x,y,z) |  z <- [5 ..], y <- [z, z-1 .. 1], x <- [y, y-1 .. 1], x^2 + y^2 == z^2 ]
~~~
<br />
