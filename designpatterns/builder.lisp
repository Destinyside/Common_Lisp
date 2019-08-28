


(defclass abstract-builder ()
  ((name :initarg :name :accessor bname)
    (product-1 :initarg :product1 :accessor bproduct1)
    (product-2 :initarg :product2 :accessor bproduct2)
    (product-3 :initarg :product3 :accessor bproduct3)
    (product-4 :initarg :product4 :accessor bproduct4)
    (product-5 :initarg :product5 :accessor bproduct5)))

(defclass builder-1 (abstract-builder) ())

(defclass builder-2 (abstract-builder) ())

(defgeneric build (builder))

(defmethod build (( builder builder-1 ))
  (setf (bproduct1 builder) "p1")
  (setf (bproduct3 builder) "p3")
  (setf (bproduct5 builder) "p5"))

(defmethod build (( builder builder-2 ))
  (setf (bproduct2 builder) "p2")
  (setf (bproduct4 builder) "p4"))

(defgeneric build-result (builder))


(defmethod build-result (( builder builder-1 ))
  (format t "~%~A: ~%~A ~A ~A~%" (bname builder) (bproduct1 builder) (bproduct3 builder) (bproduct5 builder))
  )

(defmethod build-result (( builder builder-2 ))
  (format t "~%~A: ~%~A ~A~%" (bname builder) (bproduct2 builder) (bproduct4 builder))
  )
  

(defvar b1 (make-instance 'builder-1 :name "b1"))
(defvar b2 (make-instance 'builder-2 :name "b2"))

(build b1)
(build-result b1)

(build b2)
(build-result b2)