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
(asdf:oos 'asdf:load-op '#:restas.file-publisher)
;https://github.com/archimag/restas-directory-publisher
;(ql:quickload "restas-directory-publisher")

(defconstant +project-path+ "/home/devin/repositories/Common_Lisp/restas/restas")

(defmacro with-html (&body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t :indent t)
				      ,@body))

(defmacro with-html-block (&body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue nil :indent t)
				      ,@body))
;(defun script (content &key path)
;  (format t "~A" content
#|
(defun file-to-str (file-path)
  (let ((str ""))
    (with-open-file (file file-path :direction :input)
      (do ((line (read-line file nil 'eof)
		 (read-line file nil 'eof)))
	((eql line 'eof) str)
	(setf str (concatenate 'string str line))))))

(defclass renderer () ())

(defmethod restas:render-object ((renderer renderer) (file pathname))
  (with-output-to-string (out)
    (format t "~A~%" file)
    (format t "~A~%" (file-to-str file))
    (file-to-str file)))

(defvar *js-dir*  (merge-pathnames (concatenate 'string +project-path+ "/js/")))

(format t "~A~%" *js-dir*)


(restas:mount-module publisher (#:restas.directory-publisher)
		     (:url "static")
		     (:render-method (make-instance 'renderer)) ;; Set custom renderer!!!
		     (restas.directory-publisher:*directory* *js-dir*)
		     (restas.directory-publisher:*autoindex* t))


(restas:mount-module
  publisher (#:restas.file-publisher)
  (:url "static")
  (restas.file-publisher:*directory* '("js/"))
  (restas.file-publisher:*files* '("js/*")))
|#

;(load "parts/header.lisp")

(load "pages/index.lisp")
(load "pages/hello.lisp")
(load "pages/resource.lisp")
(load "pages/js-test.lisp")
(load "pages/url.lisp")

(restas:debug-mode-on)
;;; start the server
(restas:start '#:restas.hello-world :port 8080)


