(defun generate-html (tags output attr)
  (format t "<~A ~A>~A</~A>" tags attr output tags))
