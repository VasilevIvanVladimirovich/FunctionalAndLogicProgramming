(define (interpritator lst)
  (if(atom? (nth 0 lst))
    (isFunc lst 0)
	"Error first func"
  )
)

(define (ffirst lst i)
(let (n (+ i 1))
    (if (list? (first(nth n lst)))
    	(isFunc (first(nth n lst)) 0)
 
    	(first(isFunc (nth n lst)0))
     )
        
	)
)


(define (plus lst i)
(let (n (+ i 1))
 (if (< n (length lst))
	(if (number? (nth n lst))
		(+ (nth n lst) (plus lst n))
        (+ (isFunc (nth n lst) 0) (plus lst n))
	)
  0
 )
)
)

(define (minus lst i)
(let (n (+ i 1))
 (if (< n (length lst))
	(if (number? (nth n lst))
		(- (nth n lst) (minus lst n))
        (- (isFunc (nth n lst) 0) (minus lst n))
	)
  0
 )
)
)

(define (multiplication lst i)
(let (n (+ i 1))
 (if (< n (length lst))
	(if (number? (nth n lst))
		(* (nth n lst) (multiplication lst n))
        (* (isFunc (nth n lst) 0) (multiplication lst n))
	)
    1 
 )
)
)

(define (division lst i)
(let (n (+ i 1))
 (if (< n (length lst))
	(if (number? (nth n lst))
		(/ (nth n lst) (division lst n))
        (/ (isFunc (nth n lst) 0) (division lst n))
	)
     1
 )
)
)

(define (checklsp lsp i)
  (if (< i (length lsp))
  (if (list? (nth i lsp))
     (cons (isFunc (nth i lsp) 0)(checklsp lsp (+ i 1)))
     (cons (nth i lsp) (checklsp lsp (+ i 1)))
     )
  )
)


(define (frest lst i)
(let (n (+ i 1) )
    (chop (checklsp (rest (nth n lst))0))
)
)

(define (fcons lst i)
(let (n (+ i 1) )
    (chop(checklsp lst n))
)    
)

(define (facos lst i)
(let (n (+ i 1))
     (if (number? (nth n lst))
	 (acos (nth n lst))
     (acos (isFunc (nth n lst) 0))
) 
)
)
 

(define (isFunc lst i)
(let (n(nth i lst))
(case n
     (+ (plus lst i))
     (- (minus lst i))
     (* (multiplication lst i))     
     (/ (division lst i))
     (first (ffirst lst i))
     (rest (frest lst i))
     (cons (fcons lst i))
     (acos (facos lst i))
     (true lst)
)
)
)



;(interpritator '(+ (- (* (/ 10 2)2)9)100))
;(interpritator '(first (rest (10 (+ 33 1) (- 5 1) 5 (+ 10 1)))55))
;(interpritator '(cons a b (+ 1 2)))
(interpritator '(acos (- 0 1)))