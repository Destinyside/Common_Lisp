
(in-package :cl-user)

(defpackage :binary-tree-asd
  (:use :cl :asdf))

(in-package :binary-tree-asd)

(defsystem :binary-tree
  :serial t
  :version "1.0.0"
  :description "A test for binary tree"
  :components ((:file "package")
  	       (:file "tree-node")))
