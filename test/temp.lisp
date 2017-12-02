


(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
	     ,@body)))))

(setf a 0 b 1)

(format t "~S~%" (macroexpand-1 '(once-only (a b) (format t "~A,~A~%" a b))))

(defvar names '(a b c))
(defvar gensyms (loop for n in names collect (gensym)))

(format t "~S~%" 
	`(let (,@(loop for g in gensyms collect `(,g (gensym))))
	   `(let (,,@(loop for g in gensyms for n in names collect `(,,g ,,n))) 
	      (format t "test"))))
