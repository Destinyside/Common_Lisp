
(restas:define-route 
  api-test 
  ("/api/test/*params" :content-type "application/json")
  (json:encode-json-to-string params)
  )

(restas:define-route
  api500
  ("/api/code/:(code)")
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



