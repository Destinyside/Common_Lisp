;It can convert decimal numbers to other formats,such as hex,octal and binary.
;;; maybe its badly for functional programming
(defvar *p* '())
(defun to (n num)
  (setq *p* '())
  (defun iter (i)
    (if (< n 2)
      (error "Can't Convert!")
      (if (>= i n)
	(progn
	  (setq *p* (append (list (mod i n)) *p*))
	  (iter (/ (- i (mod i n)) n))
	  )
	(setq *p* (append (list i) *p*)))))
  (iter num)
  (write *p*)
  )

