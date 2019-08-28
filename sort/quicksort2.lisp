
;;(load "random-array.lisp")

(defun random-array (n)
 (let ((lst (make-list n)))
  (maplist #'(lambda (x) (setf x (random n))) lst)))

(defun quicksort (lst)
  (cond
    ((null lst) lst)
    (t 
      (append
      (quicksort (remove-if #'(lambda (x) (> x (car lst))) (cdr lst)))
      (list (car lst))
      (quicksort (remove-if #'(lambda (x) (< x (car lst))) (cdr lst)))))))
 
(format t "~%~A~%" (quicksort (random-array (random 20))))


