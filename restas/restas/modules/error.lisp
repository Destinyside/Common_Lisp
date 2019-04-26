


(defclass mydrawer () ())

(defmethod restas:render-object 
  ((designer mydrawer) 
   (code (eql hunchentoot:+http-internal-server-error+))) 
  (setf (hunchentoot:content-type*) "text/html")
  (with-html
    (:title "500")
    (:div :class "col-xs-12 text-center"
	  (:h1
	    "500"
	    ))))

(restas:define-route 
  not-found 
  ("*any") 
  (with-html
    (:title 
      (format *standard-output* "~A" hunchentoot:+http-not-found+))
    (:div :class "col-xs-12 text-center"
	  (:h1
	    (format *standard-output* "~A : ~S." hunchentoot:+http-not-found+ any)
	    ))))

;(setf hunchentoot:*reply* (make-instance 'mydrawer))

;(restas:abort-route-handler 
;  "data invalid" 
;  :return-code hunchentoot:+http-internal-server-error+ 
;  :content-type "text/plain")
