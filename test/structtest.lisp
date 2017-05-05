(defstruct triangle
  height bottom)

(defstruct rectangle
  height width)

(defstruct circle
  radius)

(defstruct pentagon
  side)

;;;  make-structname structname-para*  structname-p

(defun area (x)
  (cond 
    ((triangle-p x)
     (* 1/2 (triangle-height x) (triangle-bottom)))
    ((rectangle-p x)
     (* (rectangle-height x) (rectangle-width x)))
    ((circle-p x)
     (* pi (expt (circle-radius x) 2)))
    ((pentagon-p x)
     (* 10 
	(* 1/2 (pentagon-side x) (/ (/ (pentagon-side x) 2) (tan 36)))))
    ))

(let ((r (make-rectangle)))
  (setf (rectangle-height r) 2
	(rectangle-width r) 3)
  (format t "~A~%" (area r)))


