
;;; first add the "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or clisp) (load "~/quicklisp/setup.lisp")

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
  (setf (hunchentoot:content-type*) "text/html")
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js")))

    (:body (:table :class "table table-hover"
		   (:caption name)
		   (:tr
		     (:th "test1")
		     (:td "line1_1")
		     (:td "line1_2"))
		   (:tr
		     (:th "test2")
		     (:td "line2_1")
		     (:td "line2_2"))))))

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
