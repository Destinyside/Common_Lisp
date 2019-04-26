

#|

(defvar *connection*
  (dbi:connect :mysql
	       :database-name "test"
	       :username "nobody"
	       :password "1234"))

(let* ((query 
	 (dbi:prepare 
	   *connection*
	   "SELECT * FROM somewhere WHERE flag = ? OR updated_at > ?"))
       (result (dbi:execute query 0 "2011-11-01")))
  (loop for row = (dbi:fetch result)
	while row
	do (format t "~A~%" row)))

|#

(defvar *connection-sqlite*
  (dbi:connect :sqlite3
	       :database-name "data.db"))


(defun db-query (table &optional where &rest params)
  (let* ((table-str (format nil "~A" table)) 
	 (where-str (if (null where) "  " where))
	 (sql (concatenate 'string "SELECT * FROM " table-str "  " where-str))
	 (query (dbi:prepare *connection-sqlite* sql))
	 (result (apply #'dbi:execute query params))
	 (lst '()))
    (loop for row = (dbi:fetch result)
	  while row
	  do (push row lst))
    lst))

