
;;; make a route for the request of js files

(defun file-to-str (file-path)
  (let ((str ""))
	(with-open-file (file file-path :direction :input)
    	(do ((line (read-line file nil 'eof)
	       (read-line file nil 'eof)))
      ((eql line 'eof) str)
      (setf str (concatenate 'string str line))))))

(defun list-to-string-path (lst)
  (labels ((list-rec (a-list str)
		   (if (null a-list) 
		     str
		     (list-rec (cdr a-list) (concatenate 'string str "/" (string (car a-list)))))))
    (list-rec lst "")))
    	

(restas:define-route
  static
  ("/static/*filename" :content-type "text/javascript")
  (format t "~A~%" (list-to-string-path filename))
  (setf filename (string-trim "../" (list-to-string-path filename)))
  (format t "~A~%" (concatenate 'string *project-path* "/static/" filename))
  (format nil "~A~%" (file-to-str (concatenate 'string *project-path* "/static/" filename))))

