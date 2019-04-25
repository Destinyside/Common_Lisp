
;;; add require for "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or sbcl clisp) (load "~/quicklisp/setup.lisp")
;;; load restas
(asdf:operate 'asdf:load-op '#:restas)

;;; use restas define a module
(restas:define-module #:restas.hello-world
		      (:use :cl))
;;;
(in-package #:restas.hello-world)

(asdf:oos 'asdf:load-op '#:cl-who)
(asdf:oos 'asdf:load-op '#:cl-bootstrap)

(defconstant *project-path* "~/Projects/Git/Common_Lisp/restas/restas")

(defconstant *static-path* "~/Projects/Git/Common_Lisp/restas/restas/static")
(defconstant *static-url* "http://localhost:8181/")

(defun cat (&rest value-list)
  (apply #'concatenate 'string value-list))

;(defun script (content &key path)
;  (format t "~A" content
(load "template.lisp")
(load "modules/index.lisp")
(load "modules/hello.lisp")
(load "modules/test.lisp")

(ensure-directories-exist #P"/tmp/hunchentoot/")

(defclass acceptor (restas:restas-acceptor)
  ()
  (:default-initargs
    :access-log-destination #P"/tmp/hunchentoot/access_log"
    :message-log-destination #P"/tmp/hunchentoot/error_log"))

;;; start the server
(restas:start '#:restas.hello-world 
	      :port 8081
	      :acceptor-class 'acceptor)


