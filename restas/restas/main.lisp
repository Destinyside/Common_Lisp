

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

#+sbcl (defconstant +format+ :UTF-8)
#+(or clisp) (defconstant +format+ "UTF-8")
#+(or ccl clisp) (setq *default-external-format* +format+)

(defconstant +locale+ :zh)
(defparameter *messages* '())

(defconstant +project-path+ "~/Projects/Git/Common_Lisp/restas/restas")
(defconstant +static-path+ "~/Projects/Git/Common_Lisp/restas/restas/static")
(defconstant +static-url+ "http://localhost:8181/")


(defun cat (&rest value-list)
  (apply #'concatenate 'string value-list))

(load "localization/messages.lisp" :external-format +format+)
(defun msg-ref (key)
  (messages-ref +locale+ key))

(defun msg-ref-1 (key)
  (messages-ref-1 +locale+ key))

(defconstant +menus+ 
	     `(
	       (:name ,(msg-ref-1 :menu1) :url "/" :icon "home" :child nil)
	       (:name ,(msg-ref-1 :menu2) :url "#" :icon "flash"
		      :child ((:name ,(msg-ref-1 :m2-child1) :url "/test/js" :icon "pushpin")
			      (:name ,(msg-ref-1 :m2-child2) :url "/test/bs" :icon "pushpin")
			      (:name 500 :url "/test/code/500" :icon "ban-circle")
			      (:name ,(msg-ref-1 :m2-child3) :url "/test/url/1/1" :icon "pushpin"))) 
	       (:name ,(msg-ref-1 :menu3) :url "#" 
		      :child ((:name ,(msg-ref-1 :m3-child1) :url "#" :icon "pushpin") 
			      (:name ,(msg-ref-1 :m3-child2) :url "#" :icon "pushpin")))
	       (:name ,(msg-ref-1 :menu4) :url "#" :icon "tasks" :child nil)
	       (:name ,(msg-ref-1 :menu5) :url "#" :icon "inbox" :child nil)
	       (:name ,(msg-ref-1 :menu6) :url "/hello" :icon "ok" :child nil)
	       ))
(load "menus.lisp" :external-format +format+)

(setf (cl-who:html-mode) :html5)

(defclass mydrawer () ())
(load "template.lisp" :external-format +format+)
(load "modules/error.lisp" :external-format +format+)
(load "modules/index.lisp" :external-format +format+)
(load "modules/hello.lisp" :external-format +format+)
(load "modules/test.lisp" :external-format +format+)

(ensure-directories-exist #P"/tmp/hunchentoot/")

(defclass acceptor (restas:restas-acceptor)
  ()
  (:default-initargs
    :access-log-destination #P"/tmp/hunchentoot/access_log"
    :message-log-destination #P"/tmp/hunchentoot/error_log"))

(restas:debug-mode-on)
;;; start the server
(restas:start '#:restas.hello-world 
	      :port 8081
	      :acceptor-class 'acceptor)


