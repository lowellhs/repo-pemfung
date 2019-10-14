Latihan HOF
=============
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