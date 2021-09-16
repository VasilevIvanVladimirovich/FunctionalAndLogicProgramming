(define (swapp lst ft)
  (if (> (nth ft lst) (nth (+ ft 1) lst))
           (swap (lst ft) (lst (+ ft 1))))
  lst
)

(define (proxod lst ft)
	(if (< (+ ft 1) (length lst)) 
   		(proxod (swapp lst ft) (+ ft 1))
        lst
	) 
)

(define (buble-sort newlst oldlst)
  (if (= newlst oldlst)
      newlst
      (foo newlst)
      )
 )

(define (foo lst)
		(buble-sort (proxod lst 0) lst) 
        
)

(time (buble-sort '(3 1 9 2 8 4 6 8 11 12 4 6 7 8 9 999))1000)