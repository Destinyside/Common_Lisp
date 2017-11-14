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


(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

;(defun next-prime (number)
;  (loop for n from (1+ number) when (primep n) return n))
(defun next-prime (number)
  (loop for n from number when (primep n) return n))

(defmacro do-primes-0 (start end)
  `(if (> ,start ,end)
       'error
    (do ((p (next-prime ,start) (next-prime (1+ p))))
	((> p ,end) 'end)
      (format t "~d " p))))

(defmacro do-primes-1 (start end &body body)
  `(if (> ,start ,end)
       'ERROR
       (do ((p (next-prime ,start) (next-prime (1+ p))))
	   ((> p ,end) 'END)
	 (progn ,@body))))

(defmacro do-primes ((var start end) &body body)
  `(if (> ,start ,end)
       'ERROR
       (do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	   ((> ,var ,end) 'END)
	 (progn ,@body))))

(defmacro my-cond (&rest clouses)
  ;(format t "~S~%" clouses)
  `(if ,(caar clouses)
	(progn ,(cadar clouses))
       (my-cond ,@(cdr clouses) (t t))))
       
(defun test-cond (num)
  (my-cond
   ((< num 50) 'SMAIL)
   ((= num 50) 'FIT)
   ((> num 50) 'BIGGER)))

