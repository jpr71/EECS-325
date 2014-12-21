(defun has-number-p (lst)
  (cond ((null lst) nil)
        ((atom lst) (numberp lst))
        (t (or
            (has-number-p (car lst))
            (has-number-p (cdr lst))))))
