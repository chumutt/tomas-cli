#|
 This file is a part of tomas-cli
 (c) 2024 chu the pup https://dogboner.xyz (chufilthymutt@gmail.com)
 Author: chu the pup <chufilthymutt@gmail.com>
|#

(in-package #:tomas-cli)

;; Define your project functionality here...

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

(defun help ()
  (format T "~&Usage:

  tomas-cli [name]~&"))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (format t "~%welcome to T.O.M.A.S~%")
  (ask-new-game))

(defun launch ()
  (%main nil))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
