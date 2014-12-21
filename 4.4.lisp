(defun bst-elements (bst)
  (if bst (append (bst-elements (node-r bst))
                  (cons (node-elt bst) (bst-elements (node-l bst))))
      nil))

(defun bst-elements (bst)
  (let ((lst nil))
    (bst-traverse #'(lambda (x) (push x lst)) bst)
    lst))


