(defun horner (variable &rest numbers)
  (reduce #'(lambda (numb1 numb2)
              (+ (* numb1 variable) numb2))
          numbers))
