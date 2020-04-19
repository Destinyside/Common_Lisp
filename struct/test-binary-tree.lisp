;;; add require for "ASDF"
#+ecl (require 'ecl-quicklisp)
#+(or sbcl clisp) (load "~/quicklisp/setup.lisp")
;;; load restas
(defun cat (&rest value-list)
  (apply #'concatenate 'string value-list))

(defconstant +project-path+ 
    (cat (namestring (probe-file ".")) "/struct/binary-tree/"))

;(print (merge-pathnames (pathname +project-path+) "binary-tree.asd"))

(push (pathname +project-path+) asdf:*central-registry*) ;添加asd文件所在的目录

(asdf:load-system "binary-tree")

;(load (merge-pathnames (pathname +project-path+) "binary-tree.asd")) 

;(asdf:load-system "binary-tree")

(let    ((root (binary-tree:make-tree)))
    (setf root (binary-tree:insert-node root 1))
    (setf root (binary-tree:insert-node root 7))
    (setf root (binary-tree:insert-node root 2))
    (setf root (binary-tree:insert-node root 6))
    (setf root (binary-tree:insert-node root 3))
    (setf root (binary-tree:insert-node root 5))
    (setf root (binary-tree:insert-node root 4))
    (binary-tree:print-tree root :type :pre)
    (format t "~%")
    (binary-tree:print-tree root :type :mid)
    (format t "~%")
    (binary-tree:print-tree root :type :post)
    (format t "~%")
)
