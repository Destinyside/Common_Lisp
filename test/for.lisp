(defmacro for ((n) &body body)
  `(do ((i 0 (+ i 1)))
       ((= i ,n) 'break)
       ,@body))



