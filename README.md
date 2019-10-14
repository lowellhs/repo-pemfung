**Functional Programming Learning Progress**
===========================================

## Haskell Basics ##
Pada bagian ini akan ditunjukkan sintaks — sintaks yang sering digunakan nantinya. Terdapat penjelasan tentang dasar tipe data pada Haskell, bagaimana membuat fungsi dan hal yang lebih dalam dari tipe data atau fungsi.
Data Types (Tipe Data)
Pada haskell dikenal sebutan values, contohnya 5atau True yang secara berurutan dalam dunia pemrograman merupakan integer dan boolean. Himpunan values yang memiliki kemiripan contohnya `{..,5,12,100,-1,..}` atau `{ True, False}` dikenal dengan sebutan types. Types yang sering digunakan pada Haskell adalah,
* Bool<br />
Values : `{True, False}`<br />
Operasi yang dapat digunakan : `&&`, `||` dan `not`<br />
Contoh : `(x || y) && not (x && y)`
* Int<br />
Values : `{... , -5, 12, 100, 229, ...}`<br />
Operasi yang dapat digunakan : `+`, `*`, `^`, `-`, `div`, `mod`, `abs` dan `negate`<br />
Contoh : `2 + 32 * 10 ^ (2 + 1)`<br />
Maksimal nilai `2147483647`, Jika ingin dinamis gunakan tipe data Integer
* Char<br />
Values : `{'a', 'b', 'A', ...}`

List pada Haskell adalah struktur data untuk menyimpan values dengan tipe yang sama. Misalkan `[1, 2, 5, 10, 11]` merupakan list dari tipe data Int. Tipe data String merupakan list dari tipe data Char, contohnya "Hello" sehingga fungsi yang bekerja pada list dapat digunakan pada String.
Fungsi dan operator yang dapat digunakan pada list adalah,
* `++`<br />
Operator ini digunakan untuk menggabungkan dua buah list. Contohnya `[1,2,3,4]` ++ `[10,20]` akan menghasilkan `[1,2,3,4,10,20]`.
* `:` (cons operator)<br />
Operator ini digunakan untuk menambahkan elemen pada bagian awal list. Contohnya `5:[4,3,2,1]` menghasilkan `[5,4,3,2,1]`. List (misalkan) `[1,2,3]` sebenarnya berbentuk `1:2:3:[]`.
* `!!`<br />
Operator ini berguna untuk indexing pada list. Contohnya `[1, 2, 5] !! 2` menghasilkan 5 (elemen pertama merupakan index 0)

Fungsi berikut akan menggunakan list arr untuk menunjukkan hasilnya,
`let arr = [0, 1, 2, 3, 4]`
* head : head arr menghasilkan `0`
* tail : head arr menghasilkan `[1, 2, 3, 4]`
* last : head arr menghasilkan `4`
* init : head arr menghasilkan `[0, 1, 2, 3]`

Dalam membuat fungsi kita membutuhkan deklarasi dan definisi fungsi. Contoh kita ingin membuat fungsi yang menambahkan dua bilangan bernama `add`
~~~
add :: Int -> Int -> Int
add x y = x + y
~~~
Pada baris pertama merupakan deklarasi fungsi `add`. Pada deklarasi ini kita dapat melihat nama fungsi `add` memiliki tipe parameter pertama sebuah Int, parameter kedua Int dan hasilnya harus berupa Int.
Pada baris kedua merupakan definisi fungsi dengan parameter `x` dan `y` menghasilkan `x + y`.

## High-Order Function ##

### Curried Functions ###
Semua fungsi di Haskell sebenarnya hanya memiliki 1 parameter, namun fungsi yang dapat menerima beberapa parameter adalah **curried functions**. Misalkan fungsi `max 4 5` untuk mencari nilai yang lebih besar. Fungsi ini sebenarnya menerima `4` dahulu `(max 4)` kemudian baru menerima `5` yaitu `((max 4) 5)`. Ketika memanggil fungsi dengan sedikit parameter maka kita mendapatkan fungsi yang **partially applied**. Misalkan,
~~~
multIt :: (Num a) => a -> a -> a
multIt x y = x * y

doubleIt = mult 2
tripleIt = mult 3
~~~
Ketika memberikan parameter `doubleIt` memberikan hasil kelipatan dua dari parameter tersebut, begitu juga dengan `tripleIt`. Hal ini dikarenakan `doubleIt` dan `tripleIt` merupakan *partially applied* dari fungsi `multIt`.

Fungsi juga dapat menerima fungsi sebagai parameternya, contohnya
~~~
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
~~~

#### zipWith ####
Terdapat fungsi `zipWith` yang menerima parameter sebuah fungsi dan 2 buah list dimana akan menggabungkan kedua list dan mengaplikasikan fungsi yang diberikan. Definisinya berikut (`zipWith'` karena terdapat built-in function bernama `zipWith`)
~~~
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys 
~~~

#### flip ####
Fungsi `flip` menerima sebuah fungsi dan dua parameter yang dibalik posisinya, berikut contohnya,
~~~
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x
~~~
Atau dengan bentuk yang lebih simple
~~~
flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y
~~~
Pada bentuk yang pertama terlihat bahwa tanda kurung tidak diperlukan karena secara default fungsi mengalami curry. `(a -> b -> c) -> (b -> a -> c)` sama dengan `(a -> b -> c) -> b -> a -> c`. Definisi tipe ini memiliki arti fungsi `flip'` menerima sebuah fungsi yang membutuhkan parameter `a` dan `b`, kemudian return sebuah fungsi (`c`) yang membutuhkan parameter `b` dan `a` sehingga dapat ditulis pada bentuk kedua.

#### map ####
`map` menerima fungsi dan sebuah list, kemudian fungsi tersebut diaplikasikan ke semua elemen list. Berikut definisi dan deklarasi fungsinya,
~~~
map' :: (a -> b) -> [a] -> [b]  
map' _ [] = []  
map' f (x:xs) = f x : map' f xs 
~~~

#### filter ####
`filter` menerima fungsi boolean dan sebuah list, kemudian mengambil semua elemen dimana fungsi boolean terpenuhi.
~~~
filter' :: (a -> Bool) -> [a] -> [a]  
filter' _ [] = []  
filter' p (x:xs)   
    | p x       = x : filter' p xs  
    | otherwise = filter' p xs  
~~~

#### lambdas function ####
Merupakan *anonymous function* contohnya,
~~~
add = (\a b -> a + b)
~~~
Fungsi `add` berisi *anonymous function* yang menerima 2 parameter dan menghasilkan penjumlahan kedua parameter.

#### fold ####
Definisi dari `fold` adalah
~~~
fold :: (a -> b -> b) -> b -> ([a] -> b)
fold f v []     = v
fold f v (x:xs) = f x (fold f v xs)
~~~
Properti universal dari `fold` adalah,
~~~
g       []  = v
g (x : xs)  = f x (g xs)
~~~
maka dapat disimpulkan bahwa
~~~
g = fold f v
~~~
Misalkan ada fungsi untuk melakukan sumasi terhadap setiap angka di dalam list,
~~~
sums :: [Int] -> Int
sums       []   = 0
sums (x : xs)   = x + sum xs
~~~
Dengan menyamakan dengan bentuk universal maka didapat `v = 0` kemudian `x + sum xs = f x (sum xs)`. Substitusi `sum xs` dengan `y` didapat `x + y = f x y` disimpulkan `f = (+)`. Untuk bentuk `fold` adalah,
~~~
sums = fold (+) 0
~~~