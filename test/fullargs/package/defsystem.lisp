;;; system-definition := ( defsystem system-designator system-option* )
;;; 
;;; system-option := :defsystem-depends-on system-list
;;;                  | :weakly-depends-on system-list
;;;                  | :class class-name (see discussion below)
;;;                  | :build-operation operation-name
;;;                  | system-option
;;;                  | module-option
;;;                  | option
;;; 
;;; # These are only available since ASDF 3 (actually its alpha release 2.27)
;;; system-option := :homepage string
;;;                  | :bug-tracker string
;;;                  | :mailto string
;;;                  | :long-name string
;;;                  | :source-control source-control
;;;                  | :version version-specifier
;;; 
;;; source-control := (keyword string)
;;; 
;;; module-option := :components component-list
;;;                  | :serial [ t | nil ]
;;; 
;;; option :=
;;;         | :pathname pathname-specifier
;;;         | :default-component-class class-name
;;;         | :perform method-form
;;;         | :explain method-form
;;;         | :output-files method-form
;;;         | :operation-done-p method-form
;;;         | :if-feature feature-expression
;;;         | :depends-on ( dependency-def* )
;;;         | :in-order-to ( dependency+ )
;;; 
;;; 
;;; system-list := ( simple-component-name* )
;;; 
;;; component-list := ( component-def* )
;;; 
;;; component-def  := ( component-type simple-component-name option* )
;;; 
;;; component-type := :module | :file | :static-file | other-component-type
;;; 
;;; other-component-type := symbol-by-name
;;;                         (see Component types)
;;; 
;;; # This is used in :depends-on, as opposed to ``dependency,''
;;; # which is used in :in-order-to
;;; dependency-def := simple-component-name
;;;                | ( :feature feature-expression dependency-def )
;;;                  # (see Feature dependencies)
;;;                | ( :version simple-component-name version-specifier )
;;;                | ( :require module-name )
;;; 
;;; # ``dependency'' is used in :in-order-to, as opposed to
;;; # ``dependency-def''
;;; dependency := (dependent-op requirement+)
;;; requirement := (required-op required-component+)
;;; dependent-op := operation-name
;;; required-op := operation-name
;;; 
;;; simple-component-name := string
;;;                       |  symbol
;;; 
;;; pathname-specifier := pathname | string | symbol
;;; 
;;; version-specifier := string
;;;                      | (:read-file-form <pathname-specifier> <form-specifier>?)
;;;                      | (:read-file-line <pathname-specifier> <line-specifier>?)
;;; line-specifier := :at integer # base zero
;;; form-specifier := :at [ integer | ( integer+ )]
;;; 
;;; method-form := (operation-name qual lambda-list &rest body)
;;; qual := method qualifier?
;;; 
;;; feature-expression := keyword
;;;                       | (:and feature-expression*)
;;;                       | (:or feature-expression*)
;;;                       | (:not feature-expression)
