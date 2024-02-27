(load "tomas-cli.asd")

(load "tomas-cli-tests.asd")

(ql:quickload "tomas-cli-tests")

(in-package #:tomas-cli-tests)

(uiop:quit (if (run-all-tests) 0 1))
