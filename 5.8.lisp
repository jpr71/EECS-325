(defun max-min (vec &key (start 0) (end (length vec)) greatest smallest)
  (if (= start end)
      (values greatest smallest)
      (let* ((temp (svref vec start))
             (greatest (if (null greatest) temp (max temp greatest)))
             (smallest (if (null smallest) temp (min temp smallest))))
        (max-min vec :start (1+ start) :end end :greatest greatest :smallest smallest))))

