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

(load "pages/index.lisp")

;;; start the server
(restas:start '#:restas.hello-world :port 8080)
