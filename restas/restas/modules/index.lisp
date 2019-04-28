
;;; define a route 
(restas:define-route 
  login
  ("/login" :method :get)
  (with-html
    (:title "index")
    (:div :class "col-lg-12" :style "height:80%;"
	  (cl-bootstrap:bs-panel 
	    ()
	    (:div :class "col-sm-offset-3 col-sm-6 text-center"
		  (:form :method "post" :class "form-horizontal"
			 (:div :class "form-group text-center"
			       (:h2 (msg-ref :login)))
			 (:div :class "form-group"
			       (:label :for "username" :class "col-sm-3 control-label" (msg-ref :user-name))
			       (:div :class "col-sm-9"
				     (:input :class "form-control" :name "username" :type "text")))
			 (:div :class "form-group"
			       (:label :for "password" :class "col-sm-3 control-label" (msg-ref :user-password))
			       (:div :class "col-sm-9"
				     (:input :class "form-control" :name "password" :type "password")))
			 (:div :class "form-group"
			       (:button :class "col-sm-4 btn btn-default" :type "submit" (msg-ref :submit))
			       (:button :class "col-sm-offset-4 col-sm-4 btn btn-default" :type "button" :onclick "history.back();" (msg-ref :cancel))
			       )))))))

(restas:define-route
  login/post
  ("/login" :method :post)
  (let* ((username (format nil "~A" (hunchentoot:post-parameter "username")))
	 (password (format nil "~A" (hunchentoot:post-parameter "password")))
	 (user (db-query 'tl_user " where name=? and password=?" username password)))
    (if (null user)
      (progn
	(setf (hunchentoot:content-type*) "application/json")
	(json:encode-json-to-string '((state . 0) (message . "user not exist"))))
      (progn
	(let ((user-item (car user)))
	  (setf (hunchentoot:session-value :|user|) 
		(list :id (getf user-item (intern "id" :keyword))
		      :name (getf user-item (intern "name" :keyword))
		      :password (getf user-item (intern "password" :keyword)))))
	(restas:redirect 'main)))))

(restas:define-route
  logout
  ("/logout")
  (setf (hunchentoot:session-value :|user|) nil)
  (restas:redirect 'main))

(restas:define-route
  main
  ("")
  (hunchentoot:start-session)
  (with-html
    (:title "index")
    (:div :class "col-lg-12"
	  (json:encode-json hunchentoot:*session*))))
