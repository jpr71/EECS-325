(defun a (g)
  (prog1 (car g) (replace g (funcall (cadr g)))))

(defun foo (n) (list n (lambda nil (foo (1+ n)))))
