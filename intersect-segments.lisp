(defun intersect-segments (ax ay bx by cx cy dx dy)
  (let* ((beginning (subtract-vectors (list ax ay) (list cx cy)))
         (point1 (subtract-vectors (list ax ay) (list bx by)))
         (point2 (subtract-vectors (list cx cy) (list dx dy)))
         (product (cross-product point1 point2)))
    (if (= product 0)
        (parallel ax ay bx by cx cy dx dy)
        (intersection-p ax bx cx dx ay beginning point1 point2))))

(defun parallel (ax ay bx by cx cy dx dy)
  (let ((result (multiple-value-call #'parallel-segments (sort-points ax ay bx by cx cy dx dy))))
    (cond ((null result) nil)
          ((eql (slope ax ay bx by) 'point)
           (if (eql (slope cx cy dx dy) 'point)
               (values-list result)
             (values (car result) (cadr result) (car result) (cadr result))))
          (t (values-list result)))))


(defun intersection-p (ax bx cx dx ay beginning point1 point2)
  (let ((result (add-vectors
                 (scalar-multiply (/ (cross-product beginning point2)
                                     (cross-product point1 point2))
                                  point1) (list ax ay))))
    (if (check-point (car result) ax bx cx dx)
        (values-list result)
      nil)))

(defun parallel-segments (ax ay bx by cx cy dx dy)
  (let ((s1 (slope ax ay bx by))
        (s2 (slope cx cy dx dy)))
    (cond ((/= (y-intercept ax ay s1) (y-intercept cx cy s2)) nil)
          ((and (>= dx bx cx) (null s1) s2) (list bx by bx by))
          ((and (> ax cx) (< bx dx)) (list ax ay bx by))
          ((>= dx bx cx) (list cx cy bx by))
          ((and (> cx ax) (< dx bx)) (list cx cy dx dy))
          ((>= dx ax cx) (list ax ay dx dy))
          (t nil))))


(defun check-point (x ax bx cx dx)
  (not (or (< x (min ax bx))
           (> x (max ax bx))
           (< x (min cx dx))
           (> x (max cx dx)))))


(defun sort-points (ax ay bx by cx cy dx dy)
  (cond ((and (<= ax bx) (<= cx dx))
         (values ax ay bx by cx cy dx dy))
        ((<= ax bx)
         (values ax ay bx by dx dy cx cy))
        ((<= bx dx)
         (values bx by ax ay cx cy dx dy))
        (t (values bx by ax ay dx dy cx cy))))


(defun y-intercept (x cy k)
  (if (numberp k)
      (- cy (* k x))
    0))

(defun slope (ax ay bx by)
  (cond
    ((and (eql ax bx)
          (eql ay by)) 'point)
        ((eql bx ax) 'undefined)
        (t (/ (- by ay) (- bx ax)))))

(defun cross-product (l1 l2)
  (- (* (car l1) (cadr l2)) (* (car l2) (cadr l1))))


(defun scalar-multiply (x l)
  (list (* (car l) x) (* (cadr l) x)))


(defun add-vectors (v1 v2)
  (list (+ (car v1) (car v2)) (+ (cadr v1) (cadr v2))))


(defun subtract-vectors (v1 v2)
  (list (- (car v2) (car v1)) (- (cadr v2) (cadr v1))))
