(define (mainf lst i)
  (if (< i (length lst))
    (if (atom? (nth i lst))
    (flat(list (char(nth i lst)) (mainf lst (+ i 1))))
    (list (mainf (nth i lst) 0) (mainf lst (+ i 1)))
        )
      
)
)



(define (translateToASCII lst)
  (filter number? (mainf lst 0))
  )



(translateToASCII '("A" "C" ("A" ("C"))((("!" "#")"&"))))