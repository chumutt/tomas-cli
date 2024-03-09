(in-package #:tomas-cli)

;; Define your project functionality here...

(defun when-loaded ()
  (load-time-value (local-time:now)))

(defun time-difference ()
  (round (realpart
          (local-time:timestamp-difference
           (local-time:now)
           (when-loaded)))))

(defmethod decay-happiness ((object creature))
  (setf (happiness object) (- (happiness object) (random 2))))

(defmethod decay-hunger ((object creature))
  (setf (hunger object) (- (hunger object) 1)))

(defmethod decay-age ((object creature))
  (setf (age object) (+ (age object) (/ 1.0 (* 24 365)))))

(defmethod give-name ((object creature))
  (format T "Type a name: ")
  (let ((nn (read-line)))
    (setf (name object) nn)))

(defmethod time-tick ((object creature))
  (decay-age object)
  (decay-hunger object)
  (decay-happiness object))

(defparameter *test-creature-0*
  (make-instance 'creature
                 :name "billy"
                 :happiness 50
                 :hunger 50
                 :age 3))

(defun greet (&optional (name "chu the pup"))
  (format T "Hello ~a from ~a!~&" name "tomas"))

(defun help ()
  (format T "~&Usage:

  tomas [name]~&"))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (greet (or (first argv)
             "dear lisp user")))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
