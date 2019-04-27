

;; (:name 'test :url ""  :child nil)



(defmacro nav-menu-item (&body body)
  "Handle menu item"
  `(let ((name (getf ,@body ':name)))
     (cl-who:with-html-output
       (*standard-output*)
       (:li (:a :href (getf ,@body :url) (:span :class (cl-who:conc "glyphicon " "glyphicon-" (getf ,@body :icon))) (format *standard-output* " ~A " name))))))


(defmacro nav-menu-dropdown (&body body)
  ""
  `(let ( ;;(id (string (gensym)))
	  (name (getf ,@body ':name)))
     (cl-who:with-html-output
       (*standard-output*)
       (:li :class "dropdown" ;(concatenate 'string "dropdown" "-" id)
	    (:a :href "#" :class "dropdown-toggle" :data-toggle "dropdown" ;;(concatenate 'string "dropdown" "-" id)
		(format *standard-output* " ~A " name)
		(:b :class "caret"))
	    (:ul :class "dropdown-menu" 
		 `,(apply #'concatenate 'string
			  (mapcar
			    #'(lambda (item)
				(nav-menu-item item))
			    (getf ,@body ':child)))
		 )))))



(defmacro nav-menus (&body body)
  "Navbar menus "
  `(let ((val ,@body))
     (cl-who:with-html-output
       (*standard-output*)
       (:ul :class "nav navbar-nav"
	    `,(apply #'concatenate 'string
		     (mapcar
		       #'(lambda (item)
			   (if (and (not (null (getf item :child))) (listp (getf item :child)))
			     (nav-menu-dropdown item)
			     (nav-menu-item item)))
		       val))))))


(defun fetch-parent-menus ()
  (let ((menu-data (db-query 'tl_menu "where state=? and parent=?" 1 0))
	(temp '()))
    (map 'list
	 #'(lambda (item)
	     (let* ((id (format nil "~A" (getf item :|id|)))
		    (name (format nil "~A" (getf item :|name|)))
		    (url (format nil "~A" (getf item :|url|)))
		    (icon (format nil "~A" (getf item :|icon|)))
		    (parent-str (format nil "~A" (getf item :|parent|)))
		    (parent (intern parent-str :keyword)))
	       (setf (getf temp (intern id :keyword))
		     (list :id id 
			   :name (msg-ref-1 (intern name :keyword)) 
			   :url url 
			   :icon icon))))
	 menu-data)
    temp))


(defun fetch-child-menus (temp)
  (let ((menu-data (db-query 'tl_menu "where state=? and parent!=?" 1 0)))
    (map 'list
	 #'(lambda (item)
	     (let* ((id (format nil "~A" (getf item :|id|)))
		    (name (format nil "~A" (getf item :|name|)))
		    (url (format nil "~A" (getf item :|url|)))
		    (icon (format nil "~A" (getf item :|icon|)))
		    (parent-str (format nil "~A" (getf item :|parent|)))
		    (parent (intern parent-str :keyword)))
	       (let* ((parent-item (getf temp parent))
		      (child (getf parent-item :child)))
		 (setf child (append child 
				     (list (list :id id 
						 :name (msg-ref-1 (intern name :keyword)) 
						 :url url 
						 :icon icon))))
		 (setf (getf parent-item :child) child)
		 (setf (getf temp parent) parent-item))))
	 menu-data)
    (remove-if-not #'listp temp)
    ))


#|
(defun fetch-parent-menus ()

  (let ((menu-data (db-query 'tl_menu "where state=? and parent=?" 1 0))
	(temp '()))
    (map 'list
	 #'(lambda (item)
	     (let* ((id (format nil "~A" (getf item :|id|)))
		    (name (format nil "~A" (getf item :|name|)))
		    (url (format nil "~A" (getf item :|url|)))
		    (icon (format nil "~A" (getf item :|icon|)))
		    (parent-str (format nil "~A" (getf item :|parent|)))
		    (parent (intern parent-str :keyword)))
	       (format t "~S ~A ~%" temp parent-str)
	       (cond
		 ((equal parent-str "0")
		  (setf (getf temp (intern id :keyword))
			(list :id id :name (msg-ref-1 (intern name :keyword)) :url url :icon icon
			      :child '())))
		 (t
		   (let* ((parent-item (getf temp parent))
			  (child (getf parent-item :child)))
		     (setf child (append child (list :id id :name (msg-ref-1 (intern name :keyword
										     )) :url url :icon icon)))
		     (setf (getf parent-item :child) child))
		   (format t "~S~%" parent-item)
		   ))))
	 menu-data)
    temp
    ))
|#
