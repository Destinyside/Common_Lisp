


(defclass subject () 
  ((name :initarg :name :accessor sname)
    (state :initarg :state1 :accessor sstate)))


(defclass real-subject (subject) ())

(defclass proxy ()
  ((name :initarg :name :accessor pname)
    (handler :initarg :handler :accessor phandler)))

(defgeneric subject-state (handler))

(defmethod subject-state ((s real-subject))
  (format t "~%~A: ~%~A~%" (sname s) (sstate s)))

(defmethod subject-state ((p proxy))
  (subject-state (phandler p)))

(defgeneric pre-request (handler))

(defmethod pre-request ((s subject))
  (setf (sstate s) "pre-requesting"))

(defgeneric post-request (handler))

(defmethod post-request ((s subject))
  (setf (sstate s) "post-requesting"))

(defgeneric request (handler))

(defmethod request ((s subject))
  (setf (sstate s) "requesting"))

(defmethod request ((p proxy))
  (pre-request (phandler p))
  (subject-state (phandler p))
  (request (phandler p))
  (subject-state (phandler p))
  (post-request (phandler p))
  (subject-state (phandler p))
    )




(defvar s1 (make-instance 'real-subject :name "s1" :state1 "init"))

(subject-state s1)

(defvar p1 (make-instance 'proxy :name "p1" :handler s1))

(subject-state s1)

(request p1)

