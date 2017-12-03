#+clisp (format t "~A~%" (argv))
#+ecl (format t "~A : ~A~%" (ext:command-args) (ext:argv 1))
#+sbcl (format t "~A~%" sb-ext:*posix-argv*)
