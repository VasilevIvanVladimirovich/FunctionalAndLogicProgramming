(define (get-sedjvik-parametr len parametr-lst n) ;Функция находит список параметров Сэджвика 
(if(= (% n 2) 0)
(if(> (* 3 (+(-(* 9 (pow 2 n))(* 9 (pow 2 (/ n 2))))1))len)
   parametr-lst
(flat(list (get-sedjvik-parametr len parametr-lst (+ n 1)) (+(-(* 9 (pow 2 n))(* 9 (pow 2 (/ n 2))))1))))
   
(if (> (* 3 (+(-(* 8 (pow 2 n))(* 6 (pow 2 (/ (+ n 1) 2))))1) ) len)
    parametr-lst
(flat(list (get-sedjvik-parametr len parametr-lst (+ n 1)) (+(-(* 8 (pow 2 n))(* 6 (pow 2 (/ (+ n 1) 2))))1))))
)
)

(define (foo indx step lst)
  (if(<= indx(- (length lst) 1))
     (sort(flat(list (foo(+ indx step) step lst) (nth indx lst)))
     ))
  )

(define (gluing sorted-lst A B)
  (if (and (nil? (nth B sorted-lst)))
      
      (gluing sorted-lst (+ A 1) 0 )
        
      	(if(< A (length(nth B sorted-lst)))
      (flat(list (nth A(nth B sorted-lst)) (gluing sorted-lst A (+ B 1) )))
      	)
      )
 )
  

(define (split-shell lst step-lst i )
(if(empty? step-lst)
	lst
   (if(> (pop step-lst) (+ i 1))
 (gluing (cons (rest(foo (+ i 1)(first step-lst) lst)) (split-shell lst step-lst (+ i 1)))0 0)
      )	
))

(define (shell-sort lst)
(split-shell lst (rest (get-sedjvik-parametr (length lst) , 0)) -1 )
)

(shell-sort '(2 3 9 2 8 4 6 8 11 12 4 6 7 8 9 999))