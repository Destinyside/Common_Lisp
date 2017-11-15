;;; file head commit

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

;; this is work in ecl but not in sbcl
(defmacro my-cond (&rest clouses)
  ;(format t "~S~%" clouses)
  `(if ,(caar clouses)
	(progn ,(cadar clouses))
       (my-cond ,@(cdr clouses) (t t))))

;; this doesn't work
(defun test-cond (num)
  (my-cond
   ((< num 50) 'SMAIL)
   ((= num 50) 'FIT)
   ((> num 50) 'BIGGER)))

(loop for n in '(a b c) collect `(,n (gensym)))

(defmacro with-gensyms-1 ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(with-gensyms-1 (f0 f1)
  (do ((f0 123 (1+ f0))
       (f1 234))
      ((= f0 f1) 'BRK)
    (format t "~A,~A~%" f0 f1)))

;; once-only
(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
	  ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
	     ,@body)))))
; (defvar names '(a b c))
; (defvar gensyms (loop for n in names collect (gensym)))
; gensyms => (#:G7222 #;G7223 #:G7224)
;  `( ,@(loop for g in gensyms collect `(,g (gensym))))
; => ((#:G7222 (GENSYM)) (#:G7223 (GENSYM)) (#:G7224 (GENSYM)))
; `(,@(loop for g in gensyms for n in names collect `(,g ,n)))
; => ((#:G7222 A) (#:G7223 B) (#:G7224 C))



(defmacro do-primes-2 ((var start end) &body body)
  (once-only (start end)
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
       ,@body)))


;; unit test

(defvar *test-name* nil)

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a : ~a~%" result *test-name* form)
  result)

(defmacro combine-results (&body forms)
  (with-gensyms-1 (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (form)
  `(report-result ,form ',form))
(defmacro check-1 (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-result ,f ',f))))
(defmacro check-2 (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

;(defun test-+ ()
;  (let ((*test-name* 'test-+))
;  (check-2
;    (= (+ 1 2) 3)
;    (= (+ 1 3) 3))))

(deftest test-+ ()
  (check-2
    (= (+ 1 2) 3)
    (= (+ 1 3) 3)))

;(defun test-* ()
;  (let ((*test-name* 'test-*))
;  (check-2
;    (= (* 1 2) 2)
;    (= (* 2 3) 6))))
(deftest test-* ()
  (check-2
    (= (* 1 2) 2)
    (= (* 2 3) 6)))
(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))
(deftest test-math ()
  (combine-results
    (test-arithmetic)))

(defun pow (num power)
  (let ((sum 1))
    (loop for n from 1 to power collect (setf sum (* sum num)))
    sum))


;; number
(type-of 123)      ; (INTEGER 0 281474976710655) 
(type-of 1.23)     ; SINGLE-FLOAT
(type-of PI)       ; LONG-FLOAT
(type-of 3/5)      ; RATIO
(type-of #c(3 4))  ; COMPLEX
#b111
#o777
#xAAA
#36rZZZ   ;#nr___

;;char
(type-of #\A)      ; STANDARD-CHAR #\Newline
(type-of #\Escape) ; BASE-CHAR #\Return #\Backspace #\Tab #\Page #\Rubout

;; =          /=             <          >             <=                >=
;; CHAR=      CHAR/=         CHAR<      CHAR>         CHAR<=            CHAR>=
;; CHAR-EQUAL CHAR-NOT-EQUAL CHAR-LESSP CHAR-GREATERP CHAR-NOT-GREATERP CHAR-NOT-LESSP

;;string
(type-of "abc")    ; (SIMPLE-BASE-STRING 3)

;; =            /=               <            >               <=                  >=
;; STRING=      STRING/=         STRING<      STRING>         STRING<=            STRING>=
;; STRING-EQUAL STRING-NOT-EQUAL STRING-LESSP STRING-GREATERP STRING-NOT-GREATERP STRING-NOT-LESSP

(string< "lisp" "lisper") ; => 4

;;vector
(vector 1 2 3)   ; => #(1 2 3)

;;array
;; make-array #:ARG0 &KEY :ADJUSTABLE :ELEMENT-TYPE :INITIAL-ELEMENT :INITIAL-CONTENTS :FILL-POINTER :DISPLACED-TO :DISPLACED-INDEX-OFFSET

(make-array 3 :initial-element nil)  ; => #(nil nil nil)

(elt #(1 2 3) 0) ; => 1

;; count find position remove substitute
;; count-if count-if-not  ~-if ~-if-not
;; remove-duplicates
;; concatenate
;; sort merge subseq search mismatch
;; every some notany notevery

(count 1 #(1 2 1 1 3 4)) ; => 3
(substitute 10 1 #(1 2 1 3 4)) ; => #(10 2 10 3 4)
(find 'c #((a 10) (c 20)) :key #'first) ; => (c 20)
(find 'c #((a 10) (p c)) :key #'second) ; => (p c)

;; map map-into reduce

;; hash table
;; make-hash-table &KEY :INITIAL-CONTENTS :KEY-TYPE :VALUE-TYPE :WARN-IF-NEEDS-REHASH-AFTER-GC :WEAK :TEST :SIZE :REHASH-SIZE :REHASH-THRESHOLD
;; :test eq eql equal equalp

(defvar h (make-hash-table)) ; => h 
(gethash 'foo h)             ; => nil,nil
(setf (gethash 'foo h) 'bar) ; => BAR
(gethash 'foo h)             ; => BAT,t

(multiple-value-bind (value present) (gethash 'foo h)
  (format t "~A ~A~%" value present))

(defun show-value (key hash-table)
  (multiple-value-bind (value present) (gethash key hash-table)
    (if present
	(format nil "Value ~a actually present." value)
	(format nil "Value ~a because key not found." value))))

(maphash #'(lambda (k v) (format t "~A ~A~%" k v)) h)


;; list




