;;;; file head commit

;;; next block commit

;; next lines commit

; commit of a single line

;;; (defun name (parameter* &key &optional &rest)
;;;    "Optional doc str."
;;;   body-form*)

(defun foo (a &optional (b 3)) (list a b))
(defun foo-2 (a &optional (b 3 b-supplied-p)) (list a b b-supplied-p)) ;{par}-supplied-p

;(defun test (&rest values)
;  (cond
;    ((null values) t)
;    (t (and (eval (car values)))
;	    (apply #'test (cdr values)))))

(defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))

(defvar j1 123)
(let ((j1 11)) (setf j1 23))
j1
(defun foo-3 (x)
  (format t "P : ~A ~%" x)
  (let ((x (+ x 1)))
    (format t "Outer : ~A ~%" x)
    (let ((x (+ x 1)))
      (format t "Inner : ~A ~%" x))
    (format t "Outer : ~A ~%" x))
  (format t "P : ~A ~%" x))

(dotimes (x 10) (format t "~d ~%" x))

(let* ((x 10)
  (y (+ x 10)))
  (list x y))

;; closure
(defparameter *count*
  (let ((count 0))
    #'(lambda () (setf count (1+ count)))))

(let ((count 0))
  (list
   #'(lambda () (incf count))
   #'(lambda () (decf count))
   #'(lambda () count)))

;; defvar init once
;; defparameter init every time
;; (defvar s 123) => S 123
;; (defvar s 234) => S 123
;; (defparameter s 234) => S 234

;; defconstant

(setf a 1 b 2 c 3)

;; when macro
(defmacro when-1 (test &body body)
  `(if ,test ,@body))





