#|
 This file is a part of tomas-cli
 (c) 2024 chu the pup https://dogboner.xyz (chufilthymutt@gmail.com)
 Author: chu the pup <chufilthymutt@gmail.com>
|#

(load "tomas-cli.asd")

(load "tomas-cli-tests.asd")

(ql:quickload "tomas-cli-tests")

(in-package #:tomas-cli-tests)

(uiop:quit (if (run-all-tests) 0 1))
