(defun generate-html (tags output &rest attr)
  (format t "<~A ~A>~A</~A>" tags attr output tags))
