
(in-package :binary-tree)

(defstruct tree-node
  (value nil :type (or null number))
  (lchild nil :type (or null tree-node))
  (rchild nil :type (or null tree-node)))

;;;maybe useless
(defun make-tree ()
  (make-tree-node))

(defun insert-node (tree value)
  (cond
    ((eql tree nil) 
     (progn
       (setf tree (make-tree-node :value value))
       tree))
    ((eql (tree-node-value tree) nil)
     (progn
       (setf tree (make-tree-node :value value))
       (setf (tree-node-value tree) value)
       tree))
    ((eql (tree-node-value tree) value) T)
    (T
      (progn
	(if (> value (tree-node-value tree))
	  (setf (tree-node-rchild tree) (insert-node (tree-node-rchild tree) value))
	  (setf (tree-node-lchild tree) (insert-node (tree-node-lchild tree) value)))
	tree))))

(defun delete-tree (tree)
  (if (not (eql (tree-node-value tree) nil))
    (progn
      (delete-tree (tree-node-lchild tree))
      (delete-tree (tree-node-rchild tree))
      (setf tree nil))))

(defun print-tree (tree &key type)
  (case type
    (:pre (pre-print tree))
    (:mid (mid-print tree))
    (:post (post-print tree))))

(defun pre-print (tree)
  (if (not (eql tree nil))
    (progn
      (format t "~A " (tree-node-value tree))
      (pre-print (tree-node-lchild tree))
      (pre-print (tree-node-rchild tree)))))


(defun mid-print (tree)
  (if (not (eql tree nil))
    (progn
      (pre-print (tree-node-lchild tree))
      (format t "~A " (tree-node-value tree))
      (pre-print (tree-node-rchild tree)))))


(defun post-print (tree)
  (if (not (eql tree nil))
    (progn
      (pre-print (tree-node-lchild tree))
      (pre-print (tree-node-rchild tree))
      (format t "~A " (tree-node-value tree)))))
