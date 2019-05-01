(DEFUN file_list (file)
	(LET ((input (OPEN file :IF-DOES-NOT-EXIST NIL))
		  (to_list NIL))
		(WHEN input
			(LOOP FOR line = (READ-LINE input NIL)
				;WHILE line DO (PUSH line to_list))
				WHILE line DO (SETQ to_list (APPEND to_list (LIST line))))
			(CLOSE input))
		(PUSH NIL to_list)
		(RETURN-FROM file_list to_list)
	)
)

(DEFUN lcs_pos (list1 list2)
	(LET ( (n1 (- (LENGTH list1) 1))
		   (n2 (- (LENGTH list2) 1))
		   (list1_pos NIL)
		   (list2_pos NIL)
		   (llength NIL);this is lcs's length
		   (lcs_len NIL);this is an array to record lcs's length
		   (prev NIL)

		 )
	 ;(print n1)
		(SETQ lcs_len (MAKE-ARRAY (LIST (+ n1 1) (+ n2 1)) :INITIAL-ELEMENT 0))
		(SETQ prev (MAKE-ARRAY (LIST (+ n1 1) (+ n2 1)) :INITIAL-ELEMENT 0))
		(LOOP FOR i FROM 1 to n1
			DO(LOOP FOR j FROM 1 to n2
				DO(COND 
					((EQUAL (NTH i list1) (NTH j list2))
						(SETF (AREF lcs_len i j) (+ (AREF lcs_len (- i 1) (- j 1)) 1))
						(SETF (AREF prev i j) 0);up and left
					)
					((< (AREF lcs_len (- i 1) j) (AREF lcs_len i (- j 1)))
						(SETF (AREF lcs_len i j) (AREF lcs_len i (- j 1)))
						(SETF (AREF prev i j) 1);left
					)
					((>= (AREF lcs_len (- i 1) j) (AREF lcs_len i (- j 1)))
						(SETF (AREF lcs_len i j) (AREF lcs_len (- i 1) j))
						(SETF (AREF prev i j) 2);up
					)
				)
			)
		)
		;following is to find the position
		(SETQ llength (AREF lcs_len n1 n2))
		(LOOP WHILE (> llength 0)
			DO(COND
				((EQUAL (AREF prev n1 n2) 0)
					(PUSH n1 list1_pos)
					(PUSH n2 list2_pos)
					(SETQ llength (- llength 1))
					(SETQ n1 (- n1 1))
					(SETQ n2 (- n2 1))
				)
				((EQUAL (AREF prev n1 n2) 1)
					(SETQ n2 (- n2 1))
				)
				((EQUAL (AREF prev n1 n2) 2)
					(SETQ n1 (- n1 1))
				)
			)
		)
;		(PRINT list1_pos)
;		(PRINT list2_pos)
		(RETURN-FROM lcs_pos (VALUES list1_pos list2_pos))
	)
)

(LET ( (list1 (file_list "file1.txt"))
	   (list2 (file_list "file2.txt"))
	   (list1_position NIL)
	   (list2_position NIL)
	   (list1_now 1)
	   (list2_now 1)
	   (num_lcs 0)

	 )

	(MULTIPLE-VALUE-BIND (l1 l2) (lcs_pos list1 list2) (SETQ list1_position l1)(SETQ list2_position l2))
	(SETQ num_lcs (LENGTH list1_position))
	;to print the result
	(LOOP WHILE (> num_lcs 0)
		DO(COND
			((>= (LENGTH list1_position) (LENGTH list2_position))
				(LOOP WHILE (< list1_now (CAR list1_position))
					DO(PROGN
						(FORMAT T "~C[31m-~A~C[0m~%" #\ESC (NTH list1_now list1) #\ESC)
						(SETQ list1_now (+ list1_now 1))
					
					)
				)
				(SETQ list1_now (+ list1_now 1))
				(SETQ list1_position (CDR list1_position))
			)
			((< (LENGTH list1_position) (LENGTH list2_position))
				(LOOP WHILE (< list2_now (CAR list2_position))
					DO(PROGN
						(FORMAT T "~C[32m-~A~C[0m~%" #\ESC (NTH list2_now list2) #\ESC)
						(SETQ list2_now (+ list2_now 1))
					)
				)
				(FORMAT T "~A~%" (NTH list2_now list2))
				(SETQ list2_now (+ list2_now 1))
				(SETQ list2_position (CDR list2_position))
				(SETQ num_lcs (- num_lcs 1))
			)
		)
	)
	(LOOP FOR i FROM list1_now TO (- (LENGTH list1) 1)
		DO(PROGN
			(FORMAT T "-~A~%" (NTH i list1))
		)
	)
	(LOOP FOR i FROM list2_now TO (- (LENGTH list2) 1)
		DO(PROGN
			(FORMAT T "+~A~%" (NTH i list2))
		)
	)

	
)
