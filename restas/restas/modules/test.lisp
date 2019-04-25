
(restas:define-route 
  jstest 
  ("/jstest")
  (with-html
    (:title "js-test")
      (:script "alert('hello world!');")
      (:script :src (cat *static-url* "js/jstest.js"))
      ))



(restas:define-route 
  url-?-? ("url/:(a)/:(b)")
  (with-html
    (:title "url-test")
    (:p (format t "the first is ~A ~%" a))
    (:p (format t "the second is ~A ~%" b))
    ))





(restas:define-route
  jstest
  ("/bs")
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
