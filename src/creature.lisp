(defclass creature ()
 ((name
   :accessor name
   :initarg :name
   :initform "???")
  (species
   :accessor species
   :initarg :species
   :initform "???")
  (subspecies
   :accessor subspecies
   :initarg :subspecies
   :initform "???")
  (infraubspecies
   :accessor infrasubspecies
   :initarg :infrasubspecies
   :initform "???")
  (description
   :accessor description
   :initarg :description
   :initform "A creature.")
  (health
   :accessor health
   :initarg :health
   :initform 100)
  (age
   :accessor age
   :initarg :age
   :initform 0)
  (height
   :accessor height
   :initarg :height
   :initform 1)
  (weight
   :accessor weight
   :initarg :weight
   :initform 1)
  (hunger
   :accessor hunger
   :initarg :hunger
   :initform 50)
  (happiness
   :accessor happiness
   :initarg :happiness
   :initform 50)
  (owns
   :accessor owns
   :initarg :owns
   :initform 'nil)
  (owned
   :accessor owned
   :initarg :owned
   :initform 'nil))
 (:documentation "A creature."))
