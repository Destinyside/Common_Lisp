
(restas:define-route 
  params-test 
  ("/test/params")
  (with-html
    (:title "params-test")
    (:div :class "col-lg-12"
	  (:pre
	    (json:encode-json (hunchentoot:get-parameters*)))
	  )))

(restas:define-route 
  params-test/post 
  ("/test/params" :method :post)
  (with-html
    (:title "params-test")
    (:div :class "col-lg-12"
	  (json:encode-json-to-string (hunchentoot:post-parameters*))
	  )))

(restas:define-route 
  js-test 
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
  (:render-method (make-instance 'mydrawer))
  (let ((return-code nil)
	(code-str (map 'string #'(lambda (x) x) code)))
    (format t "~A  ~A : ~A ~%" code-str (type-of code-str) (equal code-str "500"))
    (cond
      ((equal code-str "500") (setf return-code hunchentoot:+http-internal-server-error+))
      (t (setf return-code hunchentoot:+http-not-found+)))
    (setf (hunchentoot:return-code*) return-code))
  (with-html
    (:title code)
    (:div :class "col-lg-12 text-center"
	  (:h1 (format t "~A" code)))))



