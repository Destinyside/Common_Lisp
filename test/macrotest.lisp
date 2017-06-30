
(defmacro for (var start end &body body)
  (let ((g (gensym)))
    `(do ((,var ,start (1+ ,var))
       (,g ,end))
       ((> ,var ,g))
       ,@body)))

(for i 0 10 (princ "x_"))
