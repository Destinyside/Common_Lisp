
(defvar myfile (make-pathname :name "myfile"))

(defun write-all (file)
  (with-open-file (str file :direction :output :if-exists :append :if-does-not-exist :create)
    (do ((line (read-line t nil 'eof) 
	       (read-line t nil 'eof)))
      ((equal line "END") (format t "End~%"))
      (format str "Line: ~A~%" line))))

(defun pseudo-cat (file)
  (with-open-file (str file :direction :input)
    (do ((line (read-line str nil 'eof)
	       (read-line str nil 'eof)))
      ((eql line 'eof))
      (format t "~A~%" line))))

(write-all myfile)
(pseudo-cat myfile)

