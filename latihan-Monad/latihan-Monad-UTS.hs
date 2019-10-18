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