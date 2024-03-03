(in-package #:tomas-cli)

;; Define your project functionality here...

(defclass main (trial:main)
  ())

(defvar *player-ids* 0)

(defparameter *players-list* '())

(defparameter *pets-list* '())

(defclass domain ()
  ((name
   :initarg :name
   :initform (error "Must supply a domain name."))))

(defclass kingdom (domain)
  ((name
   :initarg :name
   :initform (error "Must supply a kingdom name."))))

(defclass phylum (kingdom)
  ((name
   :initarg :name
   :initform (error "Must supply a phylum name."))))

(defclass tclass (phylum)
  ((name
   :initarg :name
   :initform (error "Must supply a taxonomological class name."))))

(defclass order (tclass)
  ((name
   :initarg :name
   :initform (error "Must supply an order name."))))

(defclass family (order)
  ((name
   :initarg :name
   :initform (error "Must supply a family name."))))

(defclass genus (family)
  ((name
   :initarg :name
   :initform (error "Must supply a genus name."))))

(defclass species (genus)
  ((name
   :initarg :name
   :initform (error "Must supply a species name."))))

(defclass subspecies (species)
  ((name
   :initarg :name
   :initform (error "Must supply a subspecies name."))))

(defclass infrasubspecies (subspecies)
  ((name
    :initarg :name
    :initform (error "Must supply an infrasubspecies name."))))

(defclass creature ()
  ((name
    :reader name
    :initarg :name
    :type string
    :accessor name
    :initform "???"
    :documentation "The creature's name.")
   (species
    :reader species
    :initarg :species
    :type string
    :accessor species
    :initform (error "Must supply a creature species.")
    :documentation "The creature's taxonomic species.")
   (subspecies
    :reader subspecies
    :initarg :subspecies
    :type string
    :accessor subspecies
    :initform (error "Must supply a creature subspecies.")
    :documentation "The creature's taxonomic subspecies (infraspecies).")
   (infrasubspecies
    :reader infrasubspecies
    :initarg :infrasubspecies
    :type string
    :accessor infrasubspecies
    :documentation "The creature's taxonomic infrasubspecies (sub-subspecies).")
   (health
    :reader health
    :initarg :health
    :type integer
    :initform 100
    :documentation "The creature's health.")
   (hunger
    :reader hunger
    :initarg :hunger
    :type integer
    :initform 50
    :documentation "The creature's level of stomach fullness. 100 = full; 0 = empty (starving).")
   (happiness
    :reader happiness
    :initarg :happiness
    :type integer
    :initform 50
    :documentation "The creature's level of happiness."))
  (:documentation "A creature."))

(defclass pet (creature)
  ((name
    :reader name
    :initarg :name
    :accessor name
    :type string
    :initform "Unnamed pet"
    :documentation "The pet's name.")
   (owner
    :reader owner
    :initarg :owner
    :accessor owner
    :type string
    :initform ""
    :documentation "The owner of the pet (if any)."))
  (:documentation "A pet."))

(defgeneric ownedp (object)
  (:documentation "Return owner if owned, else return NIL."))

(defmethod ownedp ((object pet))
  (when (not (null (owner object)))))

(defgeneric description (object)
  (:documentation
   "Return a description of a thing
(a life-form, plant-form, an item, etc.)."))

(defmethod description ((object creature))
  (format t "Name: ~A~%" (name object))
  (format t "Taxonomy: ~A ~A ~A ~%" (species object) (subspecies object)
          (infrasubspecies object))
  (format t "Health: ~A~%" (health object))
  (format t "Hunger: ~A~%" (hunger object))
  (format t "Happiness: ~A~%" (happiness object)))

(defmethod description ((object pet))
  (format t "Name: ~A~%" (name object))
  (format t "Owned?: ~A~%" (ownedp object))
  (format t "Taxonomy: ~A ~A ~A ~%" (species object) (subspecies object)
          (infrasubspecies object))
  (format t "Health: ~A~%" (health object))
  (format t "Hunger: ~A~%" (hunger object))
  (format t "Happiness: ~A~%" (happiness object)))

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
  (format T "welcome! to T.O.M.A.S.!~%"))

(defun help ()
  "Display command-line help for this program."
  (format T "~&Usage:

  tomas-cli~&"))

(defun launch (&rest args)
  (apply #'trial:launch 'main args))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (greet)
  (launch))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
