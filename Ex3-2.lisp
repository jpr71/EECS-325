(defun stable-union (lst1 lst2)
  (append lst1 (stable-set-difference lst2 lst1)))

(defun stable-intersection (lst1 lst2)
    (cond
       ((null lst1) nil)
       ((member (car lst1) lst2) (cons (car lst1) (stable-intersection (cdr lst1) lst2)))
       (t (stable-intersection (cdr lst1) lst2))))

(defun stable-set-difference (lst1 lst2)
    (cond
      ((null lst1) nil)
      ((not (member (car lst1) lst2)) (cons (car lst1) (stable-set-difference (cdr lst1) lst2)))
      (t (stable-set-difference (cdr lst1) lst2))))

(defun occurrences (lst)
  (do ((l1 lst (cdr l1))
       (pairs (list) (if (consp (assoc '(car l1) pairs))
                          (incf (cdr (assoc '(car l1) pairs)))
                          (cons (cons (car l1) 1) pairs))))
      ((null l1) pairs)))


(defun test (l1 l2)
  (loop for x in l1
        for i from 1
        if (consp (assoc '(car l1) l2))
          do (incf (cdr (assoc '(car l1) l2)))
          else (append l2 (list (cons (car l1) 1)))))
