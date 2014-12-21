(defparameter *memory*
    (quote
     ((animal thing (flies nil)) (horse animal)
      (winged-creature animal (flies t))
      (bird winged-creature) (canary bird)
      (penguin bird (flies nil))
      (volatis-penguin penguin (flies t))
      (tweety canary) (willy penguin)
      (penny volatis-penguin)
      (pegasus (horse winged-creature)))))

(defun slot-for (role x)
  (or (assoc role (slots-of x))
      (some (lambda (a) (slot-for role a))
            (absts-of x))))

(defun slots-of (x) (cddr (assoc x *memory*)))

(defun absts-of (x)
  (listify (cadr (assoc x *memory*))))

(defun isa-p (x y)
  (or (eql x y)
      (some (lambda (a) (isa-p a y)) (absts-of x))))

(defun listify (x) (if (listp x) x (list x)))
