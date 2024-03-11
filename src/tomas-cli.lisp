(in-package #:tomas-cli)

;; Define your project functionality here...

(defparameter *adoptable-pets*
  '((alex (a husky))
    (beatrice (a dinosaur))
    (cindy (a hamster))))

(defparameter *player-owned-pets* '((test pet (a testing pet for testing))))

(defparameter *allowed-commands* '(adopt help quit))

(defun describe-pet (pet)
  `(,(car pet) ,(cadr pet)))

(defun describe-pets (player pets)
  (apply #'append (mapcar #'describe-pet (cdr (assoc player pets)))))

(defun adopt ()
  (princ "Name pet: ")
  (let ((name (read-line)))
    (pushnew name *player-owned-pets*)))

(defun help ()
  (format T "~&Usage:

  tomas-cli~&~%")
  (format T "~&Commands:

  help :: prints this help menu
  quit :: exit the game~&~%"))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
      (eval sexp)
      '(i do not know that command.)))

(defun game-read ()
  (let ((cmd (read-from-string (str:concat "(" (read-line) ")"))))
    (flet ((quote-it (x)
             (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (rest lst)))
      (cond ((str:blank? item) (cons item (tweak-text rest caps lit)))
            ((str:s-member '(#\! #\? #\.) item)
             (cons item (tweak-text rest t lit)))
            ((str:s-member '(#\") item) (tweak-text rest caps (not lit)))
            (lit (cons item (tweak-text rest nil lit)))
            ((or caps lit) (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ
   (coerce
    (tweak-text (coerce (str:trim (prin1-to-string lst) :char-bag "() ") 'list)
                t
                nil)
    'string))
  (fresh-line))

(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))

(defvar *playtime-epoch* nil)

(defun get-when-loaded ()
  (load-time-value (local-time:now)))

(defun set-when-loaded ()
  (setf *playtime-epoch* (get-when-loaded)))

(defvar *pid* nil)

(defun get-pid ()
  (uiop:getenv "USER"))

(defun set-pid ()
  (setf *pid* (get-pid)))

(defun startup-setup ()
  (progn
    (set-when-loaded)
    (set-pid)
    (game-repl)))

(defun %main (argv)
  "Parse CLI args."
  (when (member "-h" argv :test #'equal)
    ;; To properly parse command line arguments, use a third-party library such as
    ;; clingon, unix-opts, defmain, adopt… when needed.
    (help)
    (uiop:quit))
  (startup-setup))

(defun main ()
  "Entry point for the executable.
  Reads command line arguments."
  ;; uiop:command-line-arguments returns a list of arguments (sans the script name).
  ;; We defer the work of parsing to %main because we call it also from the Roswell script.
  (%main (uiop:command-line-arguments)))
