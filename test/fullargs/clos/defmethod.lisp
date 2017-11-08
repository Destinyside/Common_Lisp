;;; defmethod function-name {method-qualifier}*
;;;           specialized-lambda-list
;;;           [[ {declaration}* | doc-string]]
;;;           {form}*
;;; 
;;; function-name ::= {symbol | (setf symbol)}
;;; method-qualifier ::= non-nil-atom 
;;; parameter-specializer-name ::= symbol | (eql eql-specializer-form)

(defmethod 
  ;function-name
  test
  ;{method-qualifier}*

