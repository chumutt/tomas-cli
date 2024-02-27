#|
 This file is a part of tomas-cli
 (c) 2024 chu the pup https://dogboner.xyz (chufilthymutt@gmail.com)
 Author: chu the pup <chufilthymutt@gmail.com>
|#

"
Usage:

rlwrap sbcl --load run.lisp

or

ros -Q --load run.lisp

This loads the project's asd, loads the quicklisp dependencies, and
calls the main function.

Then, we are given the lisp prompt.

If you don't want to land in the REPL, you can (quit) below or call lisp with the --non-interactive flag.

Another solution to run the app is to build and run a binary (see README).
"

(load "tomas-cli.asd")

(ql:quickload "tomas-cli")

(in-package #:tomas-cli)

(handler-case
    (launch)
  (error (c)
    (format *error-output* "~&An error occured: ~a~&" c)
    (uiop:quit 1)))
