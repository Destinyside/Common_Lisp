;;; first add the "ASDF"
(require 'ecl-quicklisp)

;;; load the hunchentoot and hunchentoot-test
;;; learn more operations in asdf is necessary
(asdf:operate 'asdf:load-op '#:hunchentoot)
(asdf:oos 'asdf:load-op '#:hunchentoot-test)
(asdf:oos 'asdf:load-op '#:cl-who)

(defmacro with-html (&body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t)
			       ,@body))

;;; create an instance of hunchentoot
(hunchentoot:start 
  (make-instance 'hunchentoot:easy-acceptor :port 8080))

;;; a handler for specified route, the (name) is the request variable , it maybe a list
(hunchentoot:define-easy-handler 
  (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))
(hunchentoot:define-easy-handler 
  (foo :uri "/foo") ()
  (setf (hunchentoot:content-type*) "text/html")
  (with-html (:a :href "/bar" "bar"))   ;"<a href=\"/bar\">bar</a>"
  )
(hunchentoot:define-easy-handler 
  (bar :uri "/bar") ()
  (setf (hunchentoot:content-type*) "text/html")
  (with-html (:a :href "/foo" "foo"))   ;"<a href=\"/foo\">foo</a>"
  )
