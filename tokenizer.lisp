(defclass tokenizer ()
  ((tokens :initform nil
           :accessor tkns)))

(defmethod next-token-p ((tokenizer tokenizer))
  (not (null (slot-value tokenizer 'tokens))))

(defmethod next-token ((tokenizer tokenizer))
  (let ((slot (slot-value tokenizer 'tokens)))
    (setf (slot-value tokenizer 'tokens) (cdr slot))
    (car slot)))

(defun make-tokenizer (str &optional (delim #\space))
  (let ((tokener (make-instance 'tokenizer)))
    (setf (slot-value tokener 'tokens) (split-on-delim str delim))
    tokener))

(defun split-on-delim (str delim)
  (do* ((start 0 (1+ end))
        (end (position delim str) (position delim str :start start))
        (result (if (and (eql delim #\space) (eql start end))
                    nil
                    (list (subseq str start end)))
                (if (and (eql delim #\space) (or (eql start end) (null end)))
                    result
                    (cons (subseq str start end) result))))
       ((null end) (reverse result))))

(defun split-string (str &optional delim)
  (let ((tokenizer (make-tokenizer str delim)))
    (do ((l nil (cons (next-token tokenizer) l)))
        ((not (next-token-p tokenizer)) (nreverse l)))))
