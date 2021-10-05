((define (lab4let lst)
(let (mnoj (apply * lst))
(cond
((null? lst) lst)
	(true(cons mnoj (lab4let (rest lst))))
)
)
))



((define (lab4lambda lst)
((lambda (mnoj)
(cond
((null? lst) lst)
	(true(cons mnoj (lab4lambda (rest lst))))
    )
)(apply * lst))
))


		

(lab4let '(1 2 3 4 5 6))
(lab4lambda '(1 2 3 4 5 6))

