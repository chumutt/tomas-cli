(in-package #:tomas-cli)

;; Define your project functionality here...

(defvar *player-ids* 0)

(defparameter *players-list* '())

(defparameter *pets-list* '())

(defclass domain ()
  ((name
   :initarg :domain-name
   :initform (error "Must supply a domain name."))))

(defclass kingdom (domain)
  ((name
   :initarg :kingdom-name
   :initform (error "Must supply a kingdom name."))))

(defclass phylum (kingdom)
  ((name
   :initarg :phylum-name
   :initform (error "Must supply a phylum name."))))

(defclass tclass (phylum)
  ((name
   :initarg :tclass-name
   :initform (error "Must supply a taxonomological class name."))))

(defclass order (tclass)
  ((name
   :initarg :order-name
   :initform (error "Must supply an order name."))))

(defclass family (order)
  ((name
   :initarg :family-name
   :initform (error "Must supply a family name."))))

(defclass genus (family)
  ((name
   :initarg :genus-name
   :initform (error "Must supply a genus name."))))

(defclass species (genus)
  ((name
   :initarg :species-name
   :initform (error "Must supply a species name."))))

(defclass subspecies (species)
  ((name
   :initarg :subspecies-name
   :initform (error "Must supply a subspecies name."))))

(defclass infrasubspecies (subspecies)
  ((name
    :initarg :infrasubspecies-name
    :initform (error "Must supply an infrasubspecies name."))))

(defclass creature ()
  ((species
    :reader creature-species
    :initarg :species
    :type string
    :initform (error "Must supply a creature species.")
    :documentation "The creature's taxonomic species.")
   (subspecies
    :reader creature-subspecies
    :initarg :subspecies
    :type string
    :initform (error "Must supply a creature subspecies.")
    :documentation "The creature's taxonomic subspecies (infraspecies).")
   (infrasubspecies
    :reader creature-infrasubspecies
    :initarg :infrasubspecies
    :documentation "The creature's taxonomic infrasubspecies (sub-subspecies).")
   (name
    :reader creature-name
    :initarg :name
    :type string
    :initform "Unnamed creature"
    :documentation "The creature's name.")
   (health
    :reader creature-health
    :initarg :health
    :type integer
    :initform 100
    :documentation "The creature's health.")
   (hunger
    :reader creature-hunger
    :initarg :hunger
    :type integer
    :initform 50
    :documentation "The creature's level of stomach fullness. 100 = full; 0 = empty (starving).")
   (happiness
    :reader creature-happiness
    :initarg :happiness
    :type integer
    :initform 50
    :documentation "The creature's level of happiness."))
  (:documentation "A creature."))

(defclass pet (creature))

(defgeneric description (thing)
  (:documentation "Return a description of a thing (a life-form, plant-form, or an item."))

(defmethod description ((thing creature))
  (format nil "Name: ~A." creature-name)
  (format nil "Health: ~D" creature-health)
  (format nil "Hunger: ~D" creature-hunger)
  (format nil "Happiness: ~D" creature-happiness))

(defparameter *test-pet-1*
  (make-instance 'pet :species "Homo"
                      :subspecies "homonculus"
                      :infrasubspecies "sapiens"
                      :name "Test T. Tomas"))

(defparameter *test-pet-2*
  (make-instance 'pet :species "Felinus"
                      :subspecies "domesticus"
                      :name "Test Fluffy"))

(defun greet ()
  "Test function, say hello to the user."
  (format T "hello"))

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
