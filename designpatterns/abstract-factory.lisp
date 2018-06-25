

(defclass abstract-factory ()
  ((name :initarg :name :accessor factory-name)
   (product-b :initarg :product-b :initform 0 :accessor factory-product-b)
   (product-a :initarg :product-a :initform 0 :accessor factory-product-a)))

(defclass concrete-factory-1 (abstract-factory) ())

(defclass concrete-factory-2 (abstract-factory) ())

(defclass abstract-product-a ()
  ((name :initarg :name :initform "" :accessor factory-product-a-name)))

(defclass abstract-product-b ()
  ((name :initarg :name :initform "" :accessor factory-product-b-name)))

(defclass product-a-1 (abstract-product-a) ())

(defclass product-a-2 (abstract-product-a) ())

(defclass product-b-1 (abstract-product-b) ())

(defclass product-b-2 (abstract-product-b) ())

(defmethod create-product-a ((factory abstract-factory))
  (if (equal 'concrete-factory-1 (type-of factory))
    (setf (slot-value factory 'product-a) (make-instance 'product-a-1 :name "product-a-1"))
    (setf (slot-value factory 'product-a) (make-instance 'product-a-2 :name "product-a-2")))

  (format t "~A factory create the product ~A ~%" (factory-name factory) (factory-product-a-name (factory-product-a factory))))

(defmethod create-product-b ((factory abstract-factory))
  (if (equal 'concrete-factory-1 (type-of factory))
    (setf (slot-value factory 'product-b) (make-instance 'product-b-1 :name "product-b-1"))
    (setf (slot-value factory 'product-b) (make-instance 'product-b-2 :name "product-b-2")))

  (format t "~A factory create the product ~A ~%" (factory-name factory) (factory-product-b-name (factory-product-b factory))))

(defvar p1 (make-instance 'concrete-factory-1 :name "factory-1"))
(defvar p2 (make-instance 'concrete-factory-2 :name "factory-2"))

(create-product-a p1)
(create-product-b p1)
(create-product-a p2)
(create-product-b p2)


