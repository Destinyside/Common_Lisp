(defun newmem (obj lst)
    (cond
      ((null lst) nil)
      ((equal obj (car lst)) lst)
      (T (newmem obj (cdr lst)))))
