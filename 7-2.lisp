(defun map-stream (fn stream)
  (let ((variable (gensym)))
    (do ((expression (read stream nil variable) (read stream nil variable))
         (output nil (funcall fn expression)))
        ((eql expression variable) nil))))

(defun map-file (fn path)
  (with-open-file (stream path :direction :input)
    (map-stream fn stream)))
