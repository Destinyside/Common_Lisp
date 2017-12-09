;;; add require for "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or clisp) (load "~/quicklisp/setup.lisp")

(asdf:oos 'asdf:load-op '#:cl-who)

(defmacro with-html (&body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t)
                               ,@body))



(format t "~A~%" (with-html (:html (:body (:p :class "text-danger" "test")))))
