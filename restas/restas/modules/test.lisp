
(restas:define-route 
  jstest 
  ("/test/js")
  (with-html
    (:title "js-test")
    (:div :class "col-lg-12"
	  (:p "js/test")
	  (:script "alert('hello world!');")
	  )))

(restas:define-route 
  url-?-? ("/test/url/:(a)/:(b)")
  (with-html
    (:title "url-test")
    (:div :class "col-lg-12"
	  (cl-bootstrap:bs-panel
	    ()
	    (:div
	      (:p (format t "the first is ~A ~%" a))
	      (:p (format t "the second is ~A ~%" b)))))
    ))

(restas:define-route
  bstest
  ("/test/bs")
  (with-html
    (:title "bs-test")
    (:div
      (cl-bootstrap:bs-panel () "This is a panel")
      (cl-bootstrap:bs-panel-primary () "This is a primary panel")
      (cl-bootstrap:bs-panel-success () "This is a success panel")
      (cl-bootstrap:bs-panel-info () "This is a info panel")
      (cl-bootstrap:bs-panel-warning () "This is a warning panel")
      (cl-bootstrap:bs-panel-danger () "This is a danger panel")
      )))

(restas:define-route
  test500
  ("/test/code/:(code)")
  (let ((return-code nil))
    (format t "~A~%" (type-of code))
    (case code
      ("500" (setf return-code hunchentoot:+http-internal-server-error+))
      (t (setf return-code hunchentoot:+http-not-found+)))
    (setf (hunchentoot:return-code*) return-code))
  "aaa")



