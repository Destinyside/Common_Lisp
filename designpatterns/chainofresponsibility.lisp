

(defclass Handler ()
  ((level :initarg :level :accessor level)
   (name :initarg :name :accessor name)
   (next :initarg :next :accessor next)
   ))

(defmethod handleRequest ((h Handler) (lv integer))
  (if (< lv (level h))
    (format t "~A handle the request : ~A~%" (name h) lv)
    (if (null (next h))
      (format t "Can't Handle~%")
      (progn
	(format t "~A can't handle the request : ~A , forward to next.~%" (name h) lv)
	(handleRequest (next h) lv)))))


(defvar C (make-instance 'Handler :name "HandlerC" :next nil :level 1000)) 
(defvar B (make-instance 'Handler :name "HandlerB" :next C :level 100)) 
(defvar A (make-instance 'Handler :name "HandlerA" :next B :level 10)) 


(format t "Request : 5~%")
(handleRequest A 5)
(format t "Request : 50~%")
(handleRequest A 50)
(format t "Request : 500~%")
(handleRequest A 500)
(format t "Request : 5000~%")
(handleRequest A 5000)



