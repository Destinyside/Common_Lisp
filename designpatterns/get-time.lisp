(defun get-time ()
    (multiple-value-bind (s mi h d mo y) (get-decoded-time)
          (format nil "~A-~A-~A ~A:~A:~A" y mo d h mi s)))
