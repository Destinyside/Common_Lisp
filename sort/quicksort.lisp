;;(load "random-array.lisp")

(defun random-array (n)
 (let ((lst (make-list n)))
  (maplist #'(lambda (x) (setf x (random n))) lst)))

(defmacro while (test body)
 `(do ()
	 ((not ,test) 'break)
	 ;(format t "~A~%" 'running)
	 ,@body))

(defun quicksort (lst)
 (if (<= (length lst) 1)
  lst
  (let ((sign (first lst)))
  (append 
   (quicksort (remove-if-not #'(lambda (x) (< x sign)) lst))
   (remove-if-not #'(lambda (x) (= x sign)) lst)
   (quicksort (remove-if-not #'(lambda (x) (> x sign)) lst))))))

(format t "~A~%" (quicksort (random-array (random 20))))