(load "gettime.lisp")

(let ((instance nil))
  (defclass singleton ()
    ((data :type string :initarg :data :accessor data)))

  (defmethod getInstance ()
    (if instance
      instance
      (progn
	(setf instance (make-instance 'singleton :data (getTime)))
	instance)))
  )


