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

(defun when-loaded ()
  (load-time-value (local-time:now)))

(defun time-difference ()
  (round (realpart
          (local-time:timestamp-difference
           (local-time:now)
           (when-loaded)))))

(defmethod decay-happiness ((object creature))
  (setf (happiness object) (- (happiness object) (random 2))))

(defmethod decay-hunger ((object creature))
  (setf (hunger object) (- (hunger object) 1)))

(defmethod decay-age ((object creature))
  (setf (age object) (+ (age object) (/ 1.0 (* 24 365)))))

(defmethod give-name ((object creature))
  (format T "Type a name: ")
  (let ((nn (read-line)))
    (setf (name object) nn)))

(defmethod time-tick ((object creature))
  (decay-age object)
  (decay-hunger object)
  (decay-happiness object))

(defparameter *test-creature-0*
  (make-instance 'creature
                 :name "billy"
                 :happiness 50
                 :hunger 50
                 :age 3))

