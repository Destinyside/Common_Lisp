
(defclass rectangle ()
  (height width))

(defclass circle ()
  (radius))

(defgeneric area (x)
	    (:documentation "calculate the area of specified class"))

(defmethod area ((x rectangle))
  (* (slot-value x 'height) (slot-value x 'width)))

(defmethod area ((x circle))
  (* pi (expt (slot-value x 'radius) 2)))

(let ((r (make-instance 'rectangle)))
  (setf (slot-value r 'height) 2
	(slot-value r 'width) 3)
  (format t "~A~%" (area r)))

(defclass colored ()
  (color))
;;; inherit
(defclass colored-circle (circle colored)
  ())
;;; accessor are directly defined as a function to access the slot-value
(defclass circle ()
  ((radius :accessor circle-radius)
   (center :accessor circle-center)))
;;;> (setf c (make-instance 'circle))
;;;> (setf (circle-radius c) 1) => 1
;;;> (circle-radius c) => 1

(defclass new-circle ()
  ((radius :accessor circle-radius
           :initarg :radius
           :initform 1)
   (center :accessor circle-center
           :initarg :center
           :initform (cons 0 0))))

(defclass user ()
  ((name :initarg :name :reader get-name :writer set-name)
   (age :initarg :age :reader get-age :writer set-age)))
;;; (defvar u (make-instance 'user :name "345" :age 22))
;;; (get-name u) => "345"
;;; (set-name "457" u) => "457"


(defclass fat0 ()
  ((name :initarg :name :accessor names)))
(defclass chi0 (fat0) ())

;; this will combine getName methods like ((getName c0) (getName f0)).when calling call-next-method, it would call those methods in order.
;; main method
;;auxiliary method : :before :after :around
(defgeneric getName (obj)
	    (:documentation "test call-next-method"))

;; c0 : Child
;; f0 : Child

(defmethod getName ((obj fat0))  ;if add :before,the output will be f0~ c0~ ...
  (format t "f0 : ~A~%" (names obj)))
(defmethod getName ((obj chi0))
  (format t "c0 : ~A~%" (names obj))
  (call-next-method)) ;
(defmethod getName :around ((obj chi0))
  (format t "Around : ~A~%" (names obj))
  (call-next-method))
(defmethod getName :before ((obj chi0))
  (format t "Before : ~A~%" (names obj)))
(defmethod getName :after ((obj chi0))
  (format t "After : ~A~%" (names obj)))
;(defmethod getName :around ((obj chi0))
;  (format t "Single Around :~A~%" (names obj)))
(defvar fat1 (make-instance 'fat0 :name "Father"))
(defvar chi1 (make-instance 'chi0 :name "Child"))

(getName chi1)

;;method-combination + and or list append nconc min max progn

(defclass num0 () ((value :initarg :value :accessor value-of)))
(defclass flo0 (num0) ())
(defclass int0 (flo0) ())

(defgeneric getNum (num)
	    (:documentation "test method combination")
	    (:method-combination + :most-specific-last)) ;:most-specific-last reverse the seq
(defmethod getNum + ((num int0))
  (format t "Int : ~A~%" (value-of num))
  (* (value-of num) (value-of num)))
  ;(call-next-method))
(defmethod getNum + ((num flo0))
  (format t "Float : ~A~%" (value-of num))
  (+ (value-of num) (value-of num)))
  ;(call-next-method))
(defmethod getNum + ((num num0))
  (format t "Number : ~A~%" (value-of num))
  (/ (value-of num) (value-of num)))

(format t "Answer : ~A~%" (getNum (make-instance 'int0 :value 10)))

;; multimethod
(defclass drum1 () ())
(defclass drum2 () ())
(defclass stick1 () ())
(defclass stick2 () ())

(defgeneric beat (drum stick)
	    (:documentation "beat beat"))
(defmethod beat ((drum drum1) (stick stick1)) '(drum1 stick1))
(defmethod beat ((drum drum1) (stick stick2)) '(drum1 stick2))
(defmethod beat ((drum drum2) (stick stick1)) '(drum2 stick1))
(defmethod beat ((drum drum2) (stick stick2)) '(drum2 stick2))

;; something wrong with random ...
(defun random-drum ()
  (let ((n (random 2)))
    (case n
      (0 (make-instance 'drum1))
      (1 (make-instance 'drum2)))))
(defun random-stick ()
  (let ((n (random 2)))
    (case n
      (0 (make-instance 'stick1))
      (1 (make-instance 'stick2)))))

(format t "~A~%" (beat (random-drum) (random-stick)))


;;
;; (defmethod initialize-instance :after ((account bank-account) &key) ...)
;; (remove-method #'initialize-instance) find-method find-class
;; with-slots with-accessors

