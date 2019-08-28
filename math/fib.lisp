(defun fib (n)
  (defun iter (i a b)
    (if (< i n)
      (iter (+ i 1) b (+ a b))
      (write b)))
  (iter 0 0 1))

(format t "~%~{~%~A~%~}~%" (list (fib 2) (fib 3) (fib 4) (fib 5) (fib 6)))
