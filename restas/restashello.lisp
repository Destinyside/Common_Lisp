;;; add require for "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or clisp) (load "~/quicklisp/setup.lisp")
;;; load restas
(asdf:operate 'asdf:load-op '#:restas)

;;; use restas define a module
(restas:define-module #:restas.hello-world
		      (:use :cl))
;;;
(in-package #:restas.hello-world)

(asdf:oos 'asdf:load-op '#:cl-who)

(defmacro with-html (&body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t)
				      ,@body))

;;; define a route 
(restas:define-route 
  main 
  ("" :method :get)
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"))
      (:body
	(:h1 "Hello World!")
	(:a :href "/hello" "HELLO")
	(:d)
	(:form :method :post :class "form"
	       (:div :class "col-lg-6"
		     (:div :class "col-lg-12"
			   (:label :for "name" :class "col-lg-3 control-label" "Name")
			   (:div :class "col-lg-9"
				 (:input :class "form-control" :name "name" :type "text"))
			   (:label :for "password" :class "col-lg-3 control-label" "Password")
			   (:div :class "col-lg-9"
				 (:input :class "form-control" :name "password" :type "password")))
		     (:div :class "col-lg-12"
			   (:input :class "col-lg-4 btn btn-default" :type "submit" :value "submit")
			   (:input :class "col-lg-offset-4 col-lg-4 btn btn-default" :type "button" :value "cancel")
			   )
		     ))))))

(restas:define-route
  main/post
  ("" :method :post)
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"))

      (:body
	(:a :href "/" (format t "~A" (hunchentoot:post-parameter "name")))))))


(restas:define-route 
  hello 
  ("/hello")
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js")))

    (:body (:table :class "table table-hover"
		   (:caption "test")
		   (:tr
		     (:th "test1")
		     (:td "line1_1")
		     (:td "line1_2"))
		   (:tr
		     (:th "test2")
		     (:td "line2_1")
		     (:td "line2_2"))))))

;;; start the server
(restas:start '#:restas.hello-world :port 8080)
