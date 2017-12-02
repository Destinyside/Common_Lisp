
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

