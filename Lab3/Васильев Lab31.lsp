(define (get-sedjvik-parametr len parametr-lst n) ;Ooieoey iaoiaeo nienie ia?aiao?ia Nya?aeea 
(if (< len 3)
'(nil 1)
(if(= (% n 2) 0)
(if(> (* 3 (+(-(* 9 (pow 2 n))(* 9 (pow 2 (/ n 2))))1))len)
parametr-lst
(flat(list (get-sedjvik-parametr len parametr-lst (+ n 1)) (+(-(* 9 (pow 2 n))(* 9 (pow 2 (/ n 2))))1)))) 
(if (> (* 3 (+(-(* 8 (pow 2 n))(* 6 (pow 2 (/ (+ n 1) 2))))1) ) len)
parametr-lst
(flat(list (get-sedjvik-parametr len parametr-lst (+ n 1)) (+(-(* 8 (pow 2 n))(* 6 (pow 2 (/ (+ n 1) 2))))1)))))))
(define (foo indx step lst)
(if(<= indx(- (length lst) 1))
(sort(flat(list (foo(+ indx step) step lst) (nth indx lst))))))
(define (gluing sortedlst A B)
(if (nil? (nth B sortedlst))
(gluing sortedlst (+ A 1) 0 )
(if(< A (length(nth B sortedlst)))
(flat(list (nth A(nth B sortedlst))(gluing sortedlst A (+ B 1)))))))
(define (split-shell lst sedjvik i )
(if(empty? sedjvik)
lst
(if(> (last sedjvik) (+ i 1))
(gluing (cons (rest(foo (+ i 1)(last sedjvik) lst)) (split-shell lst sedjvik (+ i 1)))0 0))	))
(define (shell-sort lst)
(if (empty? lst) 
lst
(if (=(length lst)1)
lst
(filter number? (split-shell lst (rest (get-sedjvik-parametr (length lst) , 0)) -1 )))))
(shell-sort '(2))