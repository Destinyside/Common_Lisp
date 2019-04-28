


(restas:define-route
  user-main
  ("/user")
  (let ((user (hunchentoot:session-value :|user|)))
  (with-html
    (:title (msg-ref :user))
    (:div :class "col-lg-12 text-center"
	 (:table :class "table table-hover"
		 (:tr
		   (:td (format t "~A" (getf user :name)))
		   (:td (format t "~A" (getf user :password)))))))))
