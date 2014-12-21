(defun has-list-p (x)
                 (cond
                  ((null x) nil)
                  ((listp (car x)) t)
                  (t (has-list-p (cdr x)))))

(defun print-dots (a)
          (dotimes (x a) (format t ".")))

(defun print-dots (a)
                  (unless (= a 0)
                    (format t ".") (print-dots (1- a))))

(defun get-a-count (lst)
                  (do ((temp lst (cdr temp))
                       (counter 0 (+ (if (eql 'a (car temp)) (1+ counter) counter))))
                      ((null temp) counter)))
(defun get-a-count (lst)
                  (cond
                   ((null lst) 0)
                   (t (+
                       (if (eql 'a (car lst)) 1 0)
                       (get-a-count (cdr lst))))))


(defun summit (lst)
  (apply #'+ (remove nil lst)))

(defun summit (lst)
                 (if (null lst) 0
                   (let ((x (car lst)))
                     (if (null x)
                         (summit (cdr lst))
                       (+ x (summit (cdr lst)))))))
;;;The function didn't have a base case. Therefore there was no case that would terminate the recursion and it would run indefinitely. If you add the base case: (if (null lst) 0 ...) it does indeed terminate.

