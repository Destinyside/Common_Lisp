(require 'ecl-quicklisp)
(asdf:operate 'asdf:load-op '#:hunchentoot)
(asdf:oos 'asdf:load-op '#:hunchentoot-test)

(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
				   (setf (hunchentoot:content-type*) "text/plain")
				     (format nil "Hey~@[ ~A~]!" name))
