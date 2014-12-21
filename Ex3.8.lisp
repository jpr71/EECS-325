(defun show-dots (lst)
  (cond
    ((atom lst) (format t "~a" lst))
    (t  (format t "(")
        (show-dots (car lst))
        (format t " . ")
        (show-dots (cdr lst))
        (format t ")"))))

(defun show-list (lst)
  (cond
    ((atom lst) (format t "~a" lst))
    (t (format t "[")
       (show-list (car lst))
       (recursive-show-list lst)
       (format t "]"))))


(defun recursive-show-list (lst)
  (do ((l1 (cdr lst) (cdr l1)))
      ((atom l1)
       (unless (null l1) (format t " . ~a" l1)))
      (format t " ")
      (show-list (car l1))))

