;;; define-method-combination name [[?short-form-option]]
;;; define-method-combination name lambda-list
;;;                           ({method-group-specifier}*)
;;;                           [(:arguments . lambda-list)]
;;;                           [(:generic-function generic-fn-symbol)]
;;;                           [[{declaration}* | doc-string]]
;;;                           {form}*
;;; 
;;; short-form-option ::= :documentation string
;;; 		| :identity-with-one-argument boolean
;;; 		| :operator operator
;;; method-group-specifier ::= (variable {{qualifier-pattern}+ | predicate}
;;; 		[[?long-form-option]])
;;; long-form-option ::= :description format-string
;;; 		| :order order
;;; 		| :required boolean
