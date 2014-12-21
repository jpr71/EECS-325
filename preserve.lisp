(defmacro preserve (var-lst &body body)
  `((lambda ,var-lst ,@body) ,@var-lst))
