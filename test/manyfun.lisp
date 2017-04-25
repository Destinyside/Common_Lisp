(defun newmem (obj lst)
  (cond
    ((null lst) nil)
    ((equal obj (car lst)) lst)
    (T (newmem obj (cdr lst)))))

;;; ~A parameter
;;; ~% like \n
(defun mem-prt (obj lst)
  (format t "~A in ~A is ~A ~%" obj lst (newmem obj lst)))

(defun ask-mem ()
  (format t "~%Please enter a number and a list in (),i will compute whether the number is in the list or not : ~%")
  (let ((obj (read))
	(lst (read)))
    (if (listp lst)
      (mem-prt obj lst)
      (format t "the list entered is not a list! ~%"))))
;(funcall #'ask-mem)

;;; def global 
(defparameter *db* nil)
;;; def constant
(defconstant pi 3.14159265358979323846264338327950288)
;;; global or constant ?
(format t "the ~A is global or constant is : ~A ~%"'*db* (boundp *db*))
(format t "the ~A is global or constant is : ~A ~%"'pi (boundp 'pi))

;;;let , bindings parallelly
;this will show an error
;(let ((a 1)
;      (b 2)
;      (a 3))
;  (format t "~A ~%" (+ a b)))
;
;this is correct
(let ((a 1)
      (b 2))
  (format t "let : ~A ~%" (+ a b)))

;;;let* , bindings sequentially
(let* ((a 1)
       (b 2)
       (a 3))
  (format t "let* : ~A ~%" (+ a b)))

;;;It seems that setf is a primary macro while setq is a special form
;;;Access Fun     Update Fun      Update Using setf
;;;----------------------------------------------------------------------
;;;x           (setq x datum)       (setf x datum)
;;;(car x)     (rplaca x datum)     (setf (car x) datum)
;;;(symbol-value x) (set x datum) (setf (symbol-value x) datum)
(setf *db* pi)
(format t "set *db* to pi : ~A ~%" *db*)


;;; format
(defun val-format (p)
  (format t "~A :~%  ~A ~%~%" p (eval p)))

(val-format '(list (and (listp 3) t) (+ 1 2)))

;;; a fun judge the first element of the list
(defun enigma (x) 
  (and 
    (not (null x)) 
    (or (null (car x)) 
	(enigma (cdr x)))))
(val-format '(enigma '(1 2 3 4 5 6)))
(val-format '(enigma '(() 2 3 4 5 6)))
(val-format '(enigma '(1 2 3 4 5 (6 7 ()))))
(val-format '(enigma '(1 2 3 4 5 (6 7 (8 9)))))

;;; another fun show the first position of the number in the list
(defun mystery (x y) 
  (if (null y) 
    nil 
    (if (eql (car y) x) 
      0 
      (let ((z (mystery x (cdr y)))) 
	(and z (+ z 1))))))

(val-format '(mystery 1 '(1 2 1 3 4 1 1 1 3 2 1)))

;;; test of remove

(setf *db* '(c a r a t))
(val-format '(remove 'a *db*))
(format t "~A unchanged~%" *db*)

;;;iteration 

(defun show-squares (start end)
  (do ((i start (+ i 1)))
    ((> i end) 'done)
    (format t "~A ~A~%" i (* i i))))
(format t "old show squares : ~%")
(show-squares 2 10)

(defun new-show-squares (start end)
  (format t "~A ~A ~%" start (* start start))
  (if (< start end)
    (new-show-squares (+ start 1) end)
    ))
;(format t "new show squares : ~%")
;(new-show-squares 2 10)

;;;new show squares
;;;progn like begin
(defun show-squares (i end)
  (if (> i end)
    'done
    (progn
      (format t "~A ~A~%" i (* i i))
      (show-squares (+ i 1) end))))

;(format t "new show squares : ~%")
;(new-show-squares 2 10)

;;;dolist like map
(defun our-length (lst)
  (let ((len 0))
    (dolist (obj lst)
      (setf len (+ len 1)))
    len))

(val-format '(our-length '(1 2 3 4 5 6 7 8)))

(defun new-our-length (lst len)
  (cond
    ((null lst) len)
    (T (new-our-length (cdr lst) (+ len 1)))))

(val-format '(new-our-length '(1 2 3 4 4 3 2 2 1 1 1 3 4 1) 0))

;;;function 
(val-format `(function +))

;;;apply
(val-format '(apply #'+ (list 3 373 37 3 373 7)))

;;;funcall
(val-format '(funcall #'* 1 2 3))

;;;lambda function
(val-format '(funcall #'(lambda (x) (* x x)) 33))

(val-format '(map 'list #'(lambda (x) (* x x)) (list 1 2 3 4 5)))


;;;fixnum  integer  rational  real  number  atom 和 t 
(val-format '(typep 27 'integer))
(val-format '(typep '() T))
(val-format '(typep '() 'atom))

;;;setf car cdr consp

;;; eql equal 
;;; eql check their addr
(val-format '(eql (cons 'a nil) (cons 'a nil)))
(val-format '(eql 'a 'a))

(val-format '(setf x (cons 'a nil)))
(val-format '(eql x x))

;;; equal check two list's contains
(val-format '(equal (cons 'a nil) (cons 'a nil)))
(val-format '(equal 'a 'a))

(val-format '(equal '(a b c) '(b a c)))
(val-format '(equal '(a b c) '(a b c)))

;;; append
(val-format '(append '(a b) '(c d) 'e))

;;; compress
(defun compress (x) 
  (if (consp x) 
    (compr (car x) 1 (cdr x)) 
    x))  
(defun compr (elt n lst) 
  (if (null lst) 
    (list (n-elts elt n)) 
    (let ((next (car lst))) 
      (if (eql next elt) 
	(compr elt (+ n 1) (cdr lst)) 
	(cons (n-elts elt n) 
	      (compr next 1 (cdr lst)))))))  
(defun n-elts (elt n) 
  (if (> n 1) 
    (list n elt) 
    elt))

(val-format '(compress '(1 1 1 0 1 0 0 0 0 1)))

;;; uncompress
(defun uncompress (lst) 
  (if (null lst) 
    nil 
    (let ((elt (car lst)) 
	  (rest (uncompress (cdr lst)))) 
      (if (consp elt) 
	(append (apply #'list-of elt) rest) 
	(cons elt rest)))))  
(defun list-of (n elt) 
  (if (zerop n) 
    nil 
    (cons elt (list-of (- n 1) elt))))

(val-format '(uncompress '((3 1) 0 1 (4 0) 1)))

;;; nth nthcdr 
(val-format '(nth 0 '(a b c)))
(val-format '(nthcdr 2 '(a b c)))

;;; zerop last 
(val-format '(zerop 0))
(val-format '(zerop 1))

(val-format '(last '(a b c)))

;;; first tenth
(val-format '(first '(a b c d e f g h i j)))
(val-format '(tenth '(a b c d e f g h i j)))

;;; mapcar maplist
(val-format '(mapcar #'(lambda (x) (+ x 10)) '(1 2 3)))
(val-format '(mapcar #'list '(1 2 3) '(a b c)))

(val-format '(maplist #'(lambda (x) x) '(a b c)))

;;; mapc mapcan

;;;

;;; binary tree op
(val-format '(substitute 'y 'x '(and (integerp x) (zerop (mod x 2)))))
(val-format '(subst 'y 'x '(and (integerp x) (zerop (mod x 2)))))

;;; member 
(val-format '(member 'b '(a b c)))
(val-format '(member '(a) '((a) (z)) :test #'equal))
(val-format '(member 'a '((a b) (c d)) :key #'car))

(val-format '(member 2 '((1) (2)) :key #'car :test #'equal))
(val-format '(member 2 '((1) (2)) :test #'equal :key #'car))

(val-format '(member-if #'oddp '(2 3 4)))
;;; adjoin
(val-format '(adjoin 'b '(a b c)))
(val-format '(adjoin 'z '(a b c)))

;;; union intersection set-difference
(val-format '(union '(a b c) '(c b s)))
(val-format '(intersection '(a b c) '(b b c)))
(val-format '(set-difference '(a b c d e) '(b e)))

;;; length subseq reverse mirror?
(val-format '(subseq '(a b c d) 1 2))
(val-format '(subseq '(a b c d) 1))

(val-format '(reverse '(a b c)))

(defun mirror? (s) 
  (let ((len (length s))) 
    (and (evenp len) 
	 (let ((mid (/ len 2))) 
	   (equal (subseq s 0 mid) (reverse (subseq s mid)))))))
(val-format '(mirror? '(a b b a)))

;;; sort nth
(val-format '(sort '(0 2 1 3 8) #'>))

(defun nthmost (n lst) 
  (nth (- n 1) (sort (copy-list lst) #'>)))

(val-format '(nth 2 '(0 2 1 3 8)))

;;; every some
(val-format '(every #'oddp '(1 3 5)))
(val-format '(every #'> '(1 3 5) '(0 2 4)))
(val-format '(some #'evenp '(1 2 3)))

;;; (push obj lst) pushnew 
;;; (pop lst)
(val-format '(setf stack '(a b c)))
(val-format '(push 'd stack))
(val-format '(pop stack))

;;; dotted list  proper-list?
(val-format '(cons 'a (cons 'b (cons 'c 'd))))

;;; assoc-list consists of pairs
(val-format '(setf trans '((+ . "add") (- . "subtract"))))
(val-format '(assoc '+ trans))
(val-format '(assoc '* trans))

;;;

