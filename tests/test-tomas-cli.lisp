(in-package :tomas-cli-tests)

;; Define your project tests here...

(def-suite testmain
    :description "test suite 1")

(in-suite testmain)

(test test1
  (is (= (+ 1 1)
         2)))

(test test2
      (is (equal
           (tomas-cli::game-print '(this is a test.))
           (format t "This is a test."))))
