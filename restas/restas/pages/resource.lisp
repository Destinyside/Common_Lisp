
;;; make a route for the request of js files

(defun file-to-str (file-path)
  (let ((str ""))
	(with-open-file (file file-path :direction :input)
    	(do ((line (read-line file nil 'eof)
	       (read-line file nil 'eof)))
      ((eql line 'eof) str)
      (setf str (concatenate 'string str line))))))

(restas:define-route
  js
  ("/js/:(filename)")
  (format nil "~A~%" (file-to-str (concatenate 'string *project-path* "/js/" filename))))

(restas:define-route
  css
  ("/css/:(filename)" :content-type "text/css")
  (format nil "~A~%" (file-to-str (concatenate 'string *project-path* "/css/" filename))))

