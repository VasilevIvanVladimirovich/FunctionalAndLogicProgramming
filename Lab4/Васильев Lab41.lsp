(define (fac1 n)
  (let (x (- n 1))
  (if (= n 1) 1 
  (* n (fac1 x)))
  )
)
(define (fac2 n)
  ((lambda (x)
  (if (= n 1) 1 
  (* n (fac2 x)))
  )
(- n 1)))


(fac1 5)
(fac2 5)