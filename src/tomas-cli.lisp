(in-package #:tomas-cli)

;; Define your project functionality here...

(defclass creature ()
  ((name
    :accessor name
    :initarg :name
    :initform "???")
   (species
    :accessor species
    :initarg :species
    :initform "???")
   (subspecies
    :accessor subspecies
    :initarg :subspecies
    :initform "???")
   (infraubspecies
    :accessor infrasubspecies
    :initarg :infrasubspecies
    :initform "???")
   (description
    :accessor description
    :initarg :description
    :initform "A creature.")
   (health
    :accessor health
    :initarg :health
    :initform 100)
   (age
    :accessor age
    :initarg :age
    :initform 0)
   (height
    :accessor height
    :initarg :height
    :initform 1)
   (weight
    :accessor weight
    :initarg :weight
    :initform 1)
   (hunger
    :accessor hunger
    :initarg :hunger
    :initform 50)
   (happiness
    :accessor happiness
    :initarg :happiness
    :initform 50)
   (owns
    :accessor owns
    :initarg :owns
    :initform 'nil)
   (owned
    :accessor owned
    :initarg :owned
    :initform 'nil))
  (:documentation "A creature."))

(defmethod decay-happiness ((object creature))
  (setf (happiness object) (- (happiness object) (random 2))))

(defmethod decay-hunger ((object creature))
  (setf (hunger object) (- (hunger object) 1)))

(defmethod decay-age ((object creature))
  (setf (age object) (+ (age object) (/ 1.0 (* 24 365)))))

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
  (prog1
    (greet (or (first argv)
             "dear lisp user"))))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
