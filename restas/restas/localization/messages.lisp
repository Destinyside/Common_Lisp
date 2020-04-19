
(load (pfile "localization/messages-zh.lisp") :external-format +format+)
(load (pfile "localization/messages-en.lisp") :external-format +format+)

(defmacro messages-ref (locale key)
  `(format *standard-output* "~A" (concatenate 'string "" (getf (getf *messages* ,locale) ,key))))

(defun messages-ref-1 (locale key)
 	(concatenate 'string "" (getf (getf *messages* locale) key)))
