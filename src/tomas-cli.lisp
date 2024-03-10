(in-package #:tomas-cli)

;; Define your project functionality here...

(defvar *playtime-epoch* nil)

(defun get-when-loaded ()
  (load-time-value (local-time:now)))

(defun set-when-loaded ()
  (setf *playtime-epoch* (get-when-loaded)))

(defvar *pid* nil)

(defvar *pets* nil)

(defun get-pid ()
  (uiop:getenv "USER"))

(defun set-pid ()
  (setf *pid* (get-pid)))

(defun greet (&optional (name "chu the pup"))
  (format T "Hello ~a from ~a!~&" name "tomas"))

(defun help ()
  (format T "~&Usage:

  tomas [name]~&"))

(defun startup-setup ()
  (set-when-loaded)
  (set-pid))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (startup-setup)
  (greet (or (first argv)
             "dear lisp user")))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
