-- Rumus KPK(x, y) adalah (x*y)/FPB(x, y)
-- FPB(x, y) = FPB(y, x mod y)
-- FPB(x, y) = FPB(y, x)

fpb :: Int -> Int -> Int
fpb x 0 = x
fpb x y = fpb y (x `mod` y)

kpk :: Int -> Int -> Int
kpk x y = div (x * y) (fpb x y)