
;;(load "gettime.lisp")

(defun get-time ()
    (multiple-value-bind (s mi h d mo y) (get-decoded-time)
          (format nil "~A-~A-~A ~A:~A:~A" y mo d h mi s)))

(defclass prototype ()
  ((name :initarg :name :accessor pname)
    (arg1 :initarg :arg1 :accessor parg1)))

(defmethod clone ((p prototype))
  (make-instance 'prototype :name (pname p) :arg1 (parg1 p)))

(defmethod to-string ((p prototype))
  (format t "~% name: ~A arg1: ~A~%" (pname p) (parg1 p)))

(defvar p0 (make-instance 'prototype :name "p0" :arg1 (get-time)))

(to-string p0)

(defvar p1 (clone p0))

(to-string p1)