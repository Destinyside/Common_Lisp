(load "get-time.lisp")

(let ((instance nil))
  (defclass singleton ()
    ((data :type string :initarg :data :accessor data)))

  (defmethod get-instance ()
    (if instance
      instance
      (progn
	(setf instance (make-instance 'singleton :data (get-time)))
	instance)))
  )


