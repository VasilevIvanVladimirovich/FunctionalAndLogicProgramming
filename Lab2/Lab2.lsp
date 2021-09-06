((define (lab2 list1)
	(cond
									((null? list1) list1)
										(true(cons (apply * list1) (lab2 (rest list1))))

)
))
		

(lab2 '(1 2 3 4 5 6))

