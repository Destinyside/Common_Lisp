

(restas:define-route 
  hello 
  ("/hello")
  (with-html
    (:title "hello")
    (:div :class "col-lg-12"
	 (cl-bootstrap:bs-panel 
	   ()
	   (:table :class "table table-hover"
		   (:caption "test")
		   (:tr
		     (:th "test1")
		     (:td "line1_1")
		     (:td "line1_2"))
		   (:tr
		     (:th "test2")
		     (:td "line2_1")
		     (:td "line2_2"))))

	 (:a :href "/jstest" "js-test")
	 (:div :class "css-test" "test the function of css.")
	 )))

