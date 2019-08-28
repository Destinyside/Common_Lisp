;It can convert decimal numbers to other formats,such as hex,octal and binary.
;;; maybe its badly for functional programming
(defun to (n num)
  (defun iter (i p)
    (if (< n 2)
      (error "Can't Convert!")
      (if (>= i n)
	       (iter (/ (- i (mod i n)) n) (append (list (mod i n)) p))
	       (append (list i) p))
      ))
    (iter num '())
  )


(format t "~A~%" (to 123 45345345346353))
;; ~R 2 ~ 36
;;(format t "~16R~%" 20392039)

;; error
;; (to 1 34343)
