
(defun add-animal (name behavior)
  (list :NAME name :behavior behavior))

(defvar animals '())

(push (add-animal 'dog 'bark) animals)
(push (add-animal 'bird 'fly) animals)

(format t "~{~{~A : ~10t~A~%~}~%~}" animals)
