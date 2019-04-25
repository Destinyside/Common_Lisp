
(load "localization/messages-zh.lisp" :external-format +format+)
(load "localization/messages-en.lisp" :external-format +format+)

(defmacro messages-ref (locale key)
  `(format *standard-output* "~A" (concatenate 'string "" (getf (getf *messages* ,locale) ,key))))
