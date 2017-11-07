(defclass 
  ;class-name (make-instance 'test :arg0 0)
  test 
  ;{superclass-name}*
  ()
  ;{slot-specifier}*
  (
   ;a slot
   (
    ;slot-name
    arg0
    ;reader*  (reader0 s) 
    :reader reader0
    ;writer*  (writer0 1 s)
    :writer writer0
    ;accessor* (accessor0 s) (setf (accessor0 s) 1) 
    :accessor accessor0
    ;allocation* :instance :class
    :allocation :instance
    ;initarg*
    :initarg :arg0
    ;initform* 0 (cons 0 0) ...
    :initform 0
    ;type*
    :type integer
    ;documentation
    :documentation "arg0 slot"
    )
   )
  ;class-option
  (:default-initargs :arg0 0)
  (:documentation "test class") ;(documentation 'test 'type) (documentation (find-class 'test) t)
  ;(:metaclass nil)
  )
