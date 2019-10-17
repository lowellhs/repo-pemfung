-- Struktur data ekspresi non infix
data Expr   = C Float
            | Add Expr Expr
            | Sub Expr Expr
            | Mul Expr Expr
            | Div Expr Expr

-- evaluasi non infix
evaluate :: Expr -> Float
evaluate (C x)          = x
evaluate (Add e1 e2)    = evaluate e1 + evaluate e2
evaluate (Sub e1 e2)    = evaluate e1 - evaluate e2
evaluate (Mul e1 e2)    = evaluate e1 * evaluate e2
evaluate (Div e1 e2)    = evaluate e1 / evaluate e2

-- misalkan
-- evaluate (Sub (Mul (Add (C 10) (C 2)) (C 10)) (Div (C 1000) (C 10)))
-- akan menghasilkan 20.0 karena ekivalen dengan ((10 + 2) * 10) - (1000 / 10)