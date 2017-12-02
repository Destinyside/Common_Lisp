
(defun quicksort (lst)
  (cond
    ((null lst) lst)
    (t 
      (append
      (quicksort (remove-if #'(lambda (x) (> x (car lst))) (cdr lst)))
      (list (car lst))
      (quicksort (remove-if #'(lambda (x) (< x (car lst))) (cdr lst)))))))

(load "/root/Common_Lisp/sort/randomarray.lisp") ;random-array
(format t "~A~%" (quicksort (random-array (random 20))))
