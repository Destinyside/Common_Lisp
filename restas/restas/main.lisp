

;;; add require for "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or sbcl clisp) (load "~/quicklisp/setup.lisp")
;;; load restas
(asdf:operate 'asdf:load-op '#:restas)

;;; use restas define a module
(restas:define-module #:restas.tools
		      (:use :cl))

;;;
(in-package #:restas.tools)
;; html template
(asdf:oos 'asdf:load-op '#:cl-who)
;; bootstrap
(asdf:oos 'asdf:load-op '#:cl-bootstrap)
;; css
(asdf:oos 'asdf:load-op '#:cl-css)
;; json for api
(asdf:oos 'asdf:load-op '#:cl-json)
;; db access
(asdf:oos 'asdf:load-op '#:cl-dbi)

;; encode
#+sbcl (defconstant +format+ :UTF-8)
#+(or clisp) (defconstant +format+ "UTF-8")
#+(or ccl clisp) (setq *default-external-format* +format+)
;; locale and localization 
(defconstant +locale+ :zh)
(defconstant +project-name+ "Common_Lisp")
(defparameter *messages* '())

(defun cat (&rest value-list)
  (apply #'concatenate 'string value-list))

(defun ppath (path sub)
	(let* ((pos (search +project-name+  path :from-end t))
			(subpath (subseq path 0 pos)))
		(cat subpath "" +project-name+ sub)
	)
)

(defconstant +project-path+ (ppath (namestring (probe-file ".")) "/restas/restas/"))

(defconstant +static-path+ (cat +project-path+ "assets"))
;; static resource files, use nginx as a cdn
(defconstant +static-url+ "http://localhost/assets")


(defun pfile (fpath)
	(cat +project-path+ fpath)
)

(load (pfile "modules/db.lisp") :external-format +format+)

(load (pfile "localization/messages.lisp") :external-format +format+)

(defun msg-ref (key)
  (messages-ref +locale+ key))

(defun msg-ref-1 (key)
  (messages-ref-1 +locale+ key))

(load (pfile "modules/menus.lisp") :external-format +format+)
(load (pfile "modules/style.lisp") :external-format +format+)

(defconstant +menus+ (fetch-child-menus (fetch-parent-menus)))

#|
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
	       (:name ,(msg-ref-1 :menu4-format) :url "/format" :icon "tasks" 
		      :child ((:name ,(msg-ref-1 :m4-child1-json) :url "/format/json" :icon "pushbin")
			      (:name ,(msg-ref-1 :m4-child2-xml) :url "/format/xml" :icon "pushbin")))
	       (:name ,(msg-ref-1 :menu5) :url "#" :icon "inbox" :child nil)
	       (:name ,(msg-ref-1 :menu6) :url "/hello" :icon "ok" :child nil)
	       ))

|#

(setf (cl-who:html-mode) :html5)

(defclass mydrawer () ())
(load (pfile "template.lisp") :external-format +format+)
(load (pfile "modules/error.lisp") :external-format +format+)
(load (pfile "modules/index.lisp") :external-format +format+)
(load (pfile "modules/hello.lisp") :external-format +format+)
(load (pfile "modules/test.lisp") :external-format +format+)
(load (pfile "modules/api.lisp") :external-format +format+)
(load (pfile "modules/user.lisp") :external-format +format+)

(ensure-directories-exist #P"/tmp/hunchentoot/")

(defclass acceptor (restas:restas-acceptor)
  ()
  (:default-initargs
    :access-log-destination #P"/tmp/hunchentoot/access_log"
    :message-log-destination #P"/tmp/hunchentoot/error_log"))

(restas:debug-mode-on)
(hunchentoot:reset-session-secret)
;;; start the server

(defconstant +server-port+ 8081)

(defun web-main ()
  (format t "starting web server at ~A ...~%" +server-port+)
  (restas:start '#:restas.tools
		:port +server-port+
		:acceptor-class 'acceptor))

(web-main)
;; save executable files 
#|
#+clisp (EXT:SAVEINITMEM 
	  (concatenate 'string +project-path+ "/toolse")
		 :QUIET t
		 :INIT-FUNCTION 'web-main
		 :EXECUTABLE t
		 :NORC t
		 )
#+sbcl (sb-ext:save-lisp-and-die 
	  "sbcle" 			  
	  :toplevel 'web-main
	  :executable t
	  )
|#
