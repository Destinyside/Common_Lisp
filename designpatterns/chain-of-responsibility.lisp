

(defclass handler ()
  ((level :initarg :level :accessor level)
   (name :initarg :name :accessor name)
   (next :initarg :next :accessor next)
   ))

(defmethod handle-request ((h handler) (lv integer))
  (if (< lv (level h))
    (format t "~A handle the request : ~A~%" (name h) lv)
    (if (null (next h))
      (format t "Can't Handle~%")
      (progn
	(format t "~A can't handle the request : ~A , forward to next.~%" (name h) lv)
	(handle-request (next h) lv)))))


(defvar C (make-instance 'handler :name "HandlerC" :next nil :level 1000)) 
(defvar B (make-instance 'handler :name "HandlerB" :next C :level 100)) 
(defvar A (make-instance 'handler :name "HandlerA" :next B :level 10)) 


(format t "Request : 5~%")
(handle-request A 5)
(format t "Request : 50~%")
(handle-request A 50)
(format t "Request : 500~%")
(handle-request A 500)
(format t "Request : 5000~%")
(handle-request A 5000)



