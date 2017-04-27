(require 'ecl-quicklisp)
(asdf:operate 'asdf:load-op '#:restas)

(restas:define-module #:restas.hello-world
		      (:use :cl))

(in-package #:restas.hello-world)

(restas:define-route main ("")
		     "<h1>Hello world!</h1>\
		     <a href=\"/hello\">hello</a>")
(restas:define-route hello ("/hello")
		     "<h1>You succeed in forwarding to path /hello</h1>")

(restas:start '#:restas.hello-world :port 8080)
