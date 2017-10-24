(defun random-array (n)
 (let ((lst (make-list n)))
  (maplist #'(lambda (x) (setf x (random n))) lst)))
