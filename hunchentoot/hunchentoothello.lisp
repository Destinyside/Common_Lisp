;;; first add the "ASDF"
(require 'ecl-quicklisp)

;;; load the hunchentoot and hunchentoot-test
;;; learn more operations in asdf is necessary
(asdf:operate 'asdf:load-op '#:hunchentoot)
(asdf:oos 'asdf:load-op '#:hunchentoot-test)

;;; create an instance of hunchentoot
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))

;;; a handler for specified route, the (name) is the request variable , it maybe a list
(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
				   (setf (hunchentoot:content-type*) "text/plain")
				     (format nil "Hey~@[ ~A~]!" name))
