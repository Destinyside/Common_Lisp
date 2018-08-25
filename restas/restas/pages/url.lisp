

(restas:define-route url-?-? ("url/:(a)/:(b)")
	(with-html
	  (:html
	    (:head)
	    (:body
		(:p (format t "the first is ~A ~%" a))
		(:p (format t "the second is ~A ~%" b))
		))))
		
