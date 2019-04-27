

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
