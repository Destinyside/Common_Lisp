

(restas:define-route 
  hello 
  ("/hello")
  (with-html
    (:html
      (:head (:link :rel "stylesheet" :href "https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css")
	     (:script :src "https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js")
	     (:script :src "https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js")
	     (:script :src "https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js")))

    (:body (:table :class "table table-hover"
		   (:caption "test")
		   (:tr
		     (:th "test1")
		     (:td "line1_1")
		     (:td "line1_2"))
		   (:tr
		     (:th "test2")
		     (:td "line2_1")
		     (:td "line2_2"))))))

