(in-package :asdf-user)

(defsystem "tomas-cli-tests"
  :description "Test suite for the tomas-cli system"
  :author "chu the pup <chufilthymutt@gmail.com>"
  :version "0.0.1"
  :depends-on (:tomas-cli
               :fiveam)
  :license "GNU GPL-3.0"
  :serial T
  :components ((:module "tests"
                        :serial T
                        :components ((:file "packages")
                                     (:file "test-tomas-cli"))))

  ;; The following would not return the right exit code on error, but still 0.
  ;; :perform (test-op (op _) (symbol-call :fiveam :run-all-tests))
  )
