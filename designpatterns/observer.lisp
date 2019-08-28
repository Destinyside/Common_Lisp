;;;; Observer design pattern
(defclass Observer ()
    ((name  :initarg :name :accessor obname))
      )
(defmethod update ((o Observer)) 
    (format t "Observer ~A Updating ~%" (obname o)))

(defclass Subject ()
    ((observers  :initform '() :initarg :observers :accessor oblist)
        (name :initarg :name :accessor suname)
	   )
      )

(defmethod add ((o Observer) (s Subject))
    (format t "Add Observer ~A to Subject ~A ~%" (obname o) (suname s))
    (let ((has nil))
      (dolist (so (oblist s))
        (if (eql (obname o) (obname so))
          (setf has (or has t))
          (setf has (or has nil)))
        )
      (if has
        nil
        (setf (oblist s) (append (oblist s) (list o)))
        )))

(defmethod removeo ((o Observer) (s Subject))
    (format t "Remove Observer ~A from Subject ~A ~%" (obname o) (suname s))
    (setf (oblist s) (remove o (oblist s))))

(defmethod notify ((s Subject))
    (format t "Subject ~A Notifing ~%" (suname s))
      (dolist (o (oblist s))
	    (update o)))

(defvar u1 (make-instance 'Observer :name 'User1))
(defvar u2 (make-instance 'Observer :name 'User2))
(defvar u3 (make-instance 'Observer :name 'User3))
(defvar s1 (make-instance 'Subject :name 'Subject1))
(slot-boundp s1 'observers)
(add u1 s1)
(add u2 s1)
(add u3 s1)
(notify s1)
(removeo u2 s1)
(notify s1)

