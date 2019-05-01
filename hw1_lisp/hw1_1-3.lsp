(DEFUN fib1 (x)
	(IF (< x 2)
		x
		(+ (fib1 (- x 1)) (fib1 (- x 2)))))

(DEFUN fib2 (y)
	(LABELS ( (fib_sum (a b y)
				(IF (> y 0)
					(fib_sum b (+ a b) (- y 1))
					a)))
		(fib_sum 0 1 y)))


(FORMAT T "Original Recursion : ~%")
(TRACE fib1)
(fib1 5)
(FORMAT T "Tail Rcursion : ~%")
(TRACE fib2)
(fib2 5)
