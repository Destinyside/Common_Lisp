;;; defgeneric function-name lambda-list
;;;                [[?option | {method-description}*]]
;;; 
;;; function-name ::= {symbol | (setf symbol)}
;;; lambda-list ::= ({var}*  
;;; 		[&optional {var | (var)}*]  
;;; 		[&rest var]
;;; 		[&key {keyword-parameter}* [&allow-other-keys]])
;;; keyword-parameter ::= var | ({var | (keyword var)}) 
;;; option ::= (:argument-precedence-order {parameter-name}+) 
;;; 	| (declare {declaration}+)
;;; 	| (:documentation string)
;;; 	| (:method-combination symbol {arg}*)
;;; 	| (:generic-function-class class-name)
;;; 	| (:method-class class-name)
;;; method-description ::= (:method {method-qualifier}*
;;;         		specialized-lambda-list
;;; 		[[ {declaration}* | documentation ]]
;;; 		{form}*)
;;; method-qualifier ::= non-nil-atom 
;;; specialized-lambda-list ::= 
;;;      ({var | (var parameter-specializer-name)}*
;;;       [&optional {var | (var [initform [supplied-p-parameter]])}*]
;;;       [&rest var]
;;;       [&key {specialized-keyword-parameter}* [&allow-other-keys]]
;;;       [&aux {var | (var [initform])}*])
;;; specialized-keyword-parameter ::=
;;;    var | ({var | (keyword var)} [initform [supplied-p-parameter]]) 
;;; parameter-specializer-name ::= symbol | (eql eql-specializer-form)

(defgeneric 
  ;function-name
  test 
