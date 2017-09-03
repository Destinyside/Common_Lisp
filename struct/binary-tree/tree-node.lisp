
(in-package :binary-tree)

(defstruct tree-node
  (value 0.0 :type single-float)
  (lchild nil :type tree-node)
  (rchild nil :type tree-node))

