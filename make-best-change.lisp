(defun make-best-change (cents &optional (lst '(25 10 5 1)))
  (values-list (reverse (car (change-maker cents lst)))))

(defun change-maker (cents lst &key (best nil) (value nil))
  (do ((coins (get-coin-group cents lst) (cdr coins))
       (best-lst best (change-maker (- cents (* (car lst) (car coins))) (cdr lst)
                                    :best best-lst :value (cons (car coins) value))))
      ((null coins) (get-value cents value best-lst))))

(defun get-coin-group (cents lst)
  (cond ((null lst) nil)
        ((null (cdr lst)) (list (floor cents (car lst))))
        (t (get-coins-lst cents lst))))

(defun get-coins-lst (cents lst)
  (let* ((num1 (1+ (floor cents (car lst))))
         (counter num1))
    (mapcar #'(lambda (x) (decf counter)) (make-list num1))))

(loop for i in lst )

(defun get-value (cents value best-lst)
  (if (or (null best-lst)
          (< cents (cdr best-lst))
          (and (< (reduce #'+ value) (reduce #'+ (car best-lst)))
               (= cents (cdr best-lst))))
      (cons value cents)
      best-lst))
