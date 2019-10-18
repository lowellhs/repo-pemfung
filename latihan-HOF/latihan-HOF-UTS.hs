-- Struktur data ekspresi non infix
-- data Expr   = C Float
--             | Add Expr Expr
--             | Sub Expr Expr
--             | Mul Expr Expr
--             | Div Expr Expr

-- evaluasi non infix
-- evaluate :: Expr -> Float
-- evaluate (C x)          = x
-- evaluate (Add e1 e2)    = evaluate e1 + evaluate e2
-- evaluate (Sub e1 e2)    = evaluate e1 - evaluate e2
-- evaluate (Mul e1 e2)    = evaluate e1 * evaluate e2
-- evaluate (Div e1 e2)    = evaluate e1 / evaluate e2

-- misalkan
-- evaluate (Sub (Mul (Add (C 10) (C 2)) (C 10)) (Div (C 1000) (C 10)))
-- akan menghasilkan 20.0 karena ekivalen dengan ((10 + 2) * 10) - (1000 / 10)

--
--
--
--
--

-- Struktur data ekspresi infix
-- data Expr   = C Float
--             | Expr :+ Expr
--             | Expr :- Expr
--             | Expr :* Expr
--             | Expr :/ Expr
--         deriving (Show)

-- evaluasi struktur data ekspresi infix
-- evaluate :: Expr -> Float
-- evaluate (C x)         = x
-- evaluate (e1 :+ e2)    = evaluate e1 + evaluate e2
-- evaluate (e1 :- e2)    = evaluate e1 - evaluate e2
-- evaluate (e1 :* e2)    = evaluate e1 * evaluate e2
-- evaluate (e1 :/ e2)    = evaluate e1 / evaluate e2

-- misalkan
-- evaluate (((C 10 :+ C 2) :* C 10) :- (C 1000 :/ C 10))
-- akan menghasilkan 20.0 karena ekivalen dengan ((10 + 2) * 10) - (1000 / 10)

--
--
--
--
--

-- mapExpr                 :: (Float -> Float) -> Expr -> Expr
-- mapExpr f (C x)         = C (f x)
-- mapExpr f (e1 :+ e2)    = (mapExpr f e1) :+ (mapExpr f e2)
-- mapExpr f (e1 :- e2)    = (mapExpr f e1) :- (mapExpr f e2)
-- mapExpr f (e1 :* e2)    = (mapExpr f e1) :* (mapExpr f e2)
-- mapExpr f (e1 :/ e2)    = (mapExpr f e1) :/ (mapExpr f e2)

-- sehingga bila dijalankan,
-- mapExpr (+3) (C 10 :+ C 12)
-- maka ekspresi menjadi C 13.0 :+ C 15.0


--
--
--
--
--

-- foldExpr f v (C x)              = v (C x)
-- foldExpr f v (e1 :+ e2)         = f ( (foldExpr f v e1) :+ (foldExpr f v e2) )
-- foldExpr f v (e1 :- e2)         = f ( (foldExpr f v e1) :- (foldExpr f v e2) )
-- foldExpr f v (e1 :* e2)         = f ( (foldExpr f v e1) :* (foldExpr f v e2) )
-- foldExpr f v (e1 :/ e2)         = f ( (foldExpr f v e1) :/ (foldExpr f v e2) )

-- evaluate' e = (\(C x) -> x) (foldExpr f id e)
--         where
--                 f ((C f1) :+ (C f2)) = (C (f1 + f2))
--                 f ((C f1) :- (C f2)) = (C (f1 - f2))
--                 f ((C f1) :* (C f2)) = (C (f1 * f2))
--                 f ((C f1) :/ (C f2)) = (C (f1 / f2))

-- misalkan
-- evaluate' (((C 10 :+ C 2) :* C 10) :- (C 1000 :/ C 10))
-- akan menghasilkan 20.0 karena ekivalen dengan ((10 + 2) * 10) - (1000 / 10)

--
--
--
--
--

-- mapExpr' g = foldExpr f gf
--         where
--                 f x = x
--                 gf (C x) = (C (g x)) 

-- sehingga bila dijalankan,
-- mapExpr' (+3) (C 10 :+ C 12)
-- maka ekspresi menjadi C 13.0 :+ C 15.0

--
--
-- Ekspresi terdapat Let
--
--

-- Struktur data baru menggunakan Let untuk variabel,
-- Sehingga harus ada fungsi subst untuk mengubah variabel menjadi konstan
-- Pada tahapan ini hanya memungkinkan 1 variabel jika ingin banyak harus
-- mendefinisikannya secara nested

data Expr  = C Float
            | Expr :+ Expr
            | Expr :- Expr
            | Expr :* Expr
            | Expr :/ Expr
            | Let String Expr Expr
            | V String
        deriving (Show)

subst v0 e0 (V v1)            = if (v0 == v1) then e0 else (V v1)
subst v0 e0 (C c)             = (C c)
subst v0 e0 (e1 :+ e2)        = (subst v0 e0 e1) :+ (subst v0 e0 e2)
subst v0 e0 (e1 :- e2)        = (subst v0 e0 e1) :- (subst v0 e0 e2)
subst v0 e0 (e1 :* e2)        = (subst v0 e0 e1) :* (subst v0 e0 e2)
subst v0 e0 (e1 :/ e2)        = (subst v0 e0 e1) :/ (subst v0 e0 e2)
subst v0 e0 (Let v1 e1 e2)    = Let v1 e1 (subst v0 e0 e2)

evaluate (C x)                = x
evaluate (e1 :+ e2)           = evaluate e1 + evaluate e2
evaluate (e1 :- e2)           = evaluate e1 - evaluate e2
evaluate (e1 :* e2)           = evaluate e1 * evaluate e2
evaluate (e1 :/ e2)           = evaluate e1 / evaluate e2
evaluate (Let v e0 e1)        = evaluate (subst v e0 e1)
evaluate (V v)                = 0.0

-- Sehingga bila dijalankan evaluate (Let "x" (C 100) (Let "y" (C 10) (V "x" :/ V "y" :+ C 12)))
-- menghasilkan 22.0, karena ekspresi tersebut sama seperti : x/y + 12 dimana x = 100 dan y = 10