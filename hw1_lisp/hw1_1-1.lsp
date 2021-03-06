(DEFUN prime (x)
(let(
		(flag 0)
	)
	(setq flag 0)
	(loop for i from 2 to (isqrt x)
		do(if (= (mod x i) 0) 
			(progn
				(setq flag 0)
				(return))
			(setq flag 1)
		)
	)
	(if (= flag 1) 
		(format t "~a is prime~%" x)
		(format t "~a isn't prime~%" x)
	)
)
)
(prime 2)
(prime 239)
(prime 999)
(prime 17)
