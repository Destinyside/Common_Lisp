
;;(load "random-array.lisp")

(defun random-array (n)
 (let ((lst (make-list n)))
  (maplist #'(lambda (x) (setf x (random n))) lst)))

(defun insertion-sort  (lst)
  (setf tmp '())
  (dolist (i lst)
    (setf tmp (insert i tmp)))
  tmp)

(defun insert (i lst)
  (format t "~A~%" lst)
  (cond
    ((null lst) (list i))
    ((<= i (car lst)) (append (list i) lst))
    ((> i (car lst)) (append (list (car lst)) (insert i (cdr lst))))
    ))

(format t "~%~A~%" (quicksort (random-array (random 20))))


