
(defun file-to-str (file-path)
  (let ((str ""))
	(with-open-file (file file-path :direction :input)
    	(do ((line (read-line file nil 'eof)
	       (read-line file nil 'eof)))
      ((eql line 'eof) str)
      (setf str (concatenate 'string str line))))))


(restas:define-route 
  jstest 
  ("/jstest")
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js")))

    (:body 
      (:script "alert('hello world!');")
      (:script (format t "~A" (file-to-str "/usr/home/freebsd/git/Common_Lisp/restas/restas/js/jstest.js")))
      )))

