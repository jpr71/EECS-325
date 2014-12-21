(defmacro nth-expr (n &rest expressions)
    `(case ,n
       ,@(loop for i in expressions
               for n from 1
               collect `((,n) ,i))))


(defmacro n-of (n expr)
  (let ((number (gensym)) (i (gensym)) (lst (gensym)))
    `(do ((,number ,n)
          (,i 0 (1+ ,i))
          (,lst nil (cons ,expr ,lst)))
         ((= ,i ,number) (nreverse ,lst)))))
