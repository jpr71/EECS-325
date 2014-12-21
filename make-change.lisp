(defun make-change (cents &optional (lst '(25 10 5 1)))
      (values-list (get-change cents lst)))

(defun get-change (cents lst)
  (if (null lst) nil
      (multiple-value-bind (x y)
                           (floor cents (car lst))
                           (cons x (get-change y (cdr lst))))))
