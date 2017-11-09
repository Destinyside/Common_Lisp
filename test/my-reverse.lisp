(defun my-reverse (lst)
  (cond 
    ((null lst))
    (t (append (reverse (cdr lst)) (car lst)))))

(my-reverse '(2 3 4))
