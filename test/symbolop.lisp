
(symbol-name 'abc)
(defun every-equal (x y)
  (format t "eq:~3A eql:~3A equal:~3A equalp:~3A  (~A ~A) ~%" (eq x y) (eql x y) (equal x y) (equalp x y) x y))

(every-equal 'a 'b)
(every-equal 'a 'a)
(every-equal 3 3)
(every-equal 3 3.0)
(every-equal 3.0 3.0)
(every-equal #c(3 -4) #c(3 -4))
(every-equal #c(3 -4.0) #c(3 -4))
(every-equal (cons 'a 'b) (cons 'a 'c))
(every-equal (cons 'a 'b) (cons 'a 'b))
(every-equal '(a . b) '(a . b))
(defvar x (cons 'a 'b))
(every-equal x x)
(setf x '(a . b))
(every-equal x x)
(every-equal #\A #\A)
(every-equal "Foo" "Foo")
(every-equal "Foo" (copy-seq "Foo"))
(every-equal "FOO" "foo")