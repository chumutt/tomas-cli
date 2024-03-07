(defun greet ()
  (format T "welcome! to T.O.M.A.S.!~%"))

(defun help ()
  "Display command-line help for this program."
  (format T "~&Usage:

  tomas-cli~&"))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (greet))

(defun launch ()
  "Calls %main with no arguments."
  (%main 'nil))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))

