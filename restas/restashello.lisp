;;; add require for "ASDF"
(require 'ecl-quicklisp)

;;; load restas
(asdf:operate 'asdf:load-op '#:restas)

;;; use restas define a module
(restas:define-module #:restas.hello-world
		      (:use :cl))
;;;
(in-package #:restas.hello-world)

;;; define a route 
(restas:define-route main ("")
		     "<h1>Hello world!</h1> \
		     <a href=\"/hello\">hello</a>")
(restas:define-route hello ("/hello")
		     "<h1>You succeed in forwarding to path /hello</h1>")
;;; start the server
(restas:start '#:restas.hello-world :port 8080)
