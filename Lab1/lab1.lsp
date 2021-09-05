;;((lambda ()
;;	(list (first '(T (U U1 U2)(U4 U6 U8))) (first '(4 6 (7 8 9) )) (first '(78 89 90 67 45)))
;;))



;;(define (two)
;;	(list (nth 2 '(T (U U1 U2) (U4 U6 U8)))(nth 2 '(4 6 (7 8 9))) (nth 2 '(78 89 90 67 45))) 
;;)
;;(two)

((define (step a)(if(number? a )(= (int (rest (bits (abs a)))) 0) "false")))

(step 255)

