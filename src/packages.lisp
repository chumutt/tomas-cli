(defpackage #:tomas-cli
  (:use #:cl+trial)
  (:shadow #:main #:launch)
  (:local-nicknames
   (#:v #:org.shirakumo.verbose))
  (:export #:main #:launch))
