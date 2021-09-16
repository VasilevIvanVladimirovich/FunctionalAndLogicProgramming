(define (paramselect leng i)
  (if(< (+ i 1) leng)
     (flat(list i (paramselect leng (+ i 1))))
     i
  )
)


(define (goend lst i)
  (select lst (paramselect (length lst) i))
  )

(goend '(1 2 3 4 5 6 7 8) 5)
;(paramselect 8 5)

#|
(define (sorting lst1 lst2 l1 l2)
  (if(= (+ l1 1) (length lst1))
     (flat(list ))
     
     
     )
     
     
     
  (if(<= (nth l1 lst1)(nth l2 lst2))
     (flat(list(nth l1 lst1) (sorting lst1 lst2 (+ l1 1) l2)))
     (flat(list(nth l2 lst2) (sorting lst1 lst2 l1 (+ l2 1))))
     
     )
  
  
  
  )

(define (glue-sort lst1 lst2)
 	(sorting lst1 lst2 0 0)
  )

#|
;(glue-sort '( 1 1 4 4 6 9 13 15) '( 2 2 4 5 9 10 15 12))