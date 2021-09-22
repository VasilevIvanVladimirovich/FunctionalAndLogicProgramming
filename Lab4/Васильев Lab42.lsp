(define (differentiation l x)
(let (znak (first l))
  (cond 
   ((atom? l)
    	(if (= l x)1 0))
   

   ((= znak '^)
    (list '* (nth 2 l)
          (list '^
          	 (nth 1 l)
          (- (nth 2 l) 1)
                )))
          		
   ((= znak '+)
    (list '+ (differentiation (nth 1 l) x)
          	 (differentiation (nth 2 l) x)))	
   ((= znak '-)
    (list '- (differentiation (nth 1 l) x)
          	 (differentiation (nth 2 l) x)))	
	((= znak '*)
     (list '+ 
           (list '*
               (differentiation (nth 1 l) x)
               (nth 2 l))
           (list '*
                (differentiation (nth 2 l) x)
                (nth 1 l))))
   ((= znak'/)
    (list '/
    (list '- 
           (list '*
               (differentiation (nth 1 l) x)
               (nth 2 l))
           (list '*
                (differentiation (nth 2 l) x)
                (nth 1 l)))
          ( list '^ (nth 2 l) 2)))
     (true 1))
     
) )   
    
     
(differentiation '(/ (^ x 3) (^ x 6)) 'x)
  