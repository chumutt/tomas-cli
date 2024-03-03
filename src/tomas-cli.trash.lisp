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

(defclass classs (phylum)
  ((name
   :initarg :classs-name
   :initform (error "Must supply a class name."))))

(defclass order (classs)
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


(defclass domain ()
  "Archaea, Bacteria, or Eukarya."
  ((name
   :initarg :name)))

(defclass kingdom (domain)
  "Animalia, Plantae, Fungi, Protista, Archaea, or Bacteria."
  (name))

(defclass phylum (kingdom)
  "Humans would be of the class 'chordata'."
  (name))

(defclass classs (phylum)
  "Humans would be of the class 'mammalia'."
  (name))

(defclass order (classs)
  "Humans are of the 'primate' order."
  (name))

(defclass family (order)
  "Humans are of the family 'hominidae'."
  (name))

(defclass genus (family)
  "The 'Homo' in 'Homo sapiens'."
  (name))



(defun launch ()
  (%main nil))

(defparameter *players-list* '())

(defparameter *pets-list* '())


(defstruct player
  (id "" :type string)
  (pets nil :type list))

(defun make-player-and-track ()
  (let ((new-player (make-player :id (concatenate 'string "puid_"
                                                  (uiop:getenv "USER")))))
    (push new-player *players-list*)
    new-player))

(defstruct pet
  (name "unnamed pet" :type string)
  (age 3 :type integer)
  (description "creature" :type string)
  (hunger 7 :type integer)
  (happiness 50 :type integer)
  (thought "nothing, at the moment." :type string))

(defun save-game (player-id game-data)
  (let ((file-name (format nil "~a-game-save.lisp" player-id)))
    (with-open-file (file file-name
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
      (prin1 game-data file))))

(defun load-game (player-id)
  (let ((file-name (format nil "~a-game-save.lisp" player-id)))
    (if (probe-file file-name)
        (with-open-file (file file-name
                              :direction :input)
          (read file))
        (format t "~%no save game data found for player-id: ~a~%" player-id))))

(defun make-pet-and-track ()
  (let ((new-pet (make-pet)))
    (push new-pet *pets-list*)
    new-pet))

(defun no-pets-p ()
  (null *pets-list*))

(defun any-pets-p ()
  (not (null *pets-list*)))

(defun exit-plainly ()
  (format t "okay."))

(defun exit-wisely ()
  (format t "~%sometimes, the true winning move is not to play."))

(defun ask-new-game-no-pets-new-pet ()
  (format t "~%wanna adopt one? (enter (y)es/(n)o): ")
  (let ((answer (read)))
    (cond ((equal answer 'y) (make-pet-and-track))
          ((equal answer 'n) (exit-plainly))
          ((not (or (equal answer 'y)
                    (equal answer 'n)))
           (exit-plainly)))))

(defun start-new-game-player-has-pets ()
  (format t "~%looks like you have (a) pet(s) already."))

(defun start-new-game-player-has-no-pets ()
  (format t "~%looks like you don't have any pets.")
  (ask-new-game-no-pets-new-pet))

(defun start-new-game ()
  (format t "starting a new game.")
  (if (no-pets-p)
      (start-new-game-player-has-no-pets)
      (start-new-game-player-has-pets)))

(defun ask-new-game ()
  (format t "new game? (enter (y)es/(n)o): ")
  (let ((answer (read)))
    (cond ((equal answer 'y) (start-new-game))
          ((equal answer 'n) (exit-wisely))
          ((not (or (equal answer 'y)
                    (equal answer 'n)))
           (exit-wisely)))))

(defstruct pet
  (name nil :type string)
  (age 0 :type integer)
  (description nil :type string)
  (hunger 0 :type integer)
  (happiness 50 :type integer)
  (thought "Nothing, at the moment." :type string))

(defun describe-pet ()
  (format t "Name: " pet-name)
  (format t "~%"))


(defun any-pets-p ()
  (not (null *pets-list*)))

(defun start-new-game ()
  (format t "~%Starting a new game.")
  (if (any-pets-p)
      (format t "~%Looks like you have (a) pet(s).")
      (format t "~%Looks like you don't have any pets."))
  (format t "~%This function doesn't really do much of anything yet."))

(defun exit-wise ()
  (format t "~%Sometimes, the true winning move is not to play."))

(defun ask-new-game ()
  (format t "New game? (Enter (Y)es/(N)o): ")
  (let ((answer (read)))
    (cond ((equal answer 'y) (start-new-game))
          ((equal answer 'n) (exit-wise))
          ((not (or (equal answer 'y)
                    (equal answer 'n)))
           (exit-wise)))))

(defun fake-loading ()
  (format t "~%[....................................................] 0%~%")
  (sleep 0.1)
  (format t   "[████████████........................................] 25%~%")
  (sleep 0.1)
  (format t   "[███████████████████████████.........................] 50%~%")
  (sleep 0.1)
  (format t   "[████████████████████████████████████████............] 75%~%")
  (sleep 0.1)
  (format t   "[████████████████████████████████████████████████████] 100%~%"))


