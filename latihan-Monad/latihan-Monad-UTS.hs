-- cond :: Robot Bool -> Robot a -> Robot a -> Robot a
-- cond p c a = do pred <- p
--                 if pred then c else a

-- cond1 p c = cond p c (return ())

-- while     :: Robot Bool -> Robot () -> Robot ()
-- while p b = cond1 p (b >> while p b)

-- EVADE --
-- evade :: Robot ()
-- evade = cond blocked
--           (do turnRight
--               move)
--           move
-- evade :: Robot ()
-- evade = do cond1 blocked turnRight 
--            move

-- MOVEN --
-- moven :: Int -> Robot ()
-- moven n = mapM_ (const move) [1..n]
-- artinya map const move ke [1,2,3,..n]
-- jadinya [const move 1, const move 2, .. const move n]
-- bentuk akhirnya move >> move >> .. >> move sebanyak n

-- DIRECTION --
-- right, left :: Direction -> Direction
-- right d = toEnum (succ (fromEnum d) `mod` 4)
-- left d  = toEnum (pred (fromEnum d) `mod` 4)
-- toEnum :: Enum a => Int -> a 
-- fromEnum :: Enum a => a -> Int

-- MAPM_ --
-- mapM_ memiliki tipe:
-- mapM_ :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
-- misalkan ada array [1, 2, 3, 4]
-- ketika dipanggil mapM_ (print) [1, 2, 3, 4]
-- ekivalen dengan print 1 >> print 2 >> print 3 >> print 4

-- FORLOOP --
-- forloop []     action = return ()
-- forloop (x:xs) action = (action x) >> (forloop xs action)