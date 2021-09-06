;;((lambda ()
;;	(list (first '(T (U U1 U2)(U4 U6 U8))) (first '(4 6 (7 8 9) )) (first '(78 89 90 67 45)))
;;))



(define (hello list1 list2 list3 one two tree)
	(if(and(>= (length list1)one)(>= (length list2)two)(>= (length list3)tree))  
	(list (nth (- one 1) list1)(nth (- two 1) list2) (nth (- tree 1) list3)) 
	"Error"
))

(hello '(T (U U1 U2) (U4 U6 U8)) '(4 6 (7 8 9)) '(78 89 90 67 45) 2 3 4)

;((define (step a)(if(number? a )(= (int (rest (bits (abs a)))) 0) "false")))

;(step 255)


