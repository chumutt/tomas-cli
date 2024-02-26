#|
 This file is a part of tomas-cli
 (c) 2024 chu the pup https://dogboner.xyz (chufilthymutt@gmail.com)
 Author: chu the pup <chufilthymutt@gmail.com>
|#

(in-package :asdf-user)

(defsystem "tomas-cli"
  :author "chu the pup <chufilthymutt@gmail.com>"
  :version "0.0.1"
  :license "GNU GPL-3.0"
  :description "neglectful parent simulator (cli)"
  :homepage ""
  :bug-tracker ""
  :source-control (:git "")

  ;; Dependencies.
  :depends-on ()

  ;; Project stucture.
  :serial T
  :components ((:module "src"
                        :serial T
                        :components ((:file "packages")
                                     (:file "tomas-cli"))))

  ;; Build a binary:
  ;; don't change this line.
  :build-operation "program-op"
  ;; binary name: adapt.
  :build-pathname "tomas-cli"
  ;; entry point: here "main" is an exported symbol. Otherwise, use a double ::
  :entry-point "tomas-cli:main")
