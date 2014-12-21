(defun baz (x y lst)
  (let ((a (assoc x lst)))
    (cond ((null a)
           (list (cons (cons x y) lst)))
          ((equal (cdr a) y) (list lst))
          (t nil))))

(defun foo (x y lsts)
  (if (null lsts) nil
    (append (baz x y (car  lsts))
            (foo x y (cdr lsts)))))
