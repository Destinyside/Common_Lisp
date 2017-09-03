
(defpackage :binary-tree
  (:nicknames :btree)
  (:use :cl)
  (:export :tree-node 
	   :make-tree-node 
	   :tree-node-lchild
	   :tree-node-rchild 
	   :tree-node-value))
