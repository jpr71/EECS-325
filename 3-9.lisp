(defun longest-path (start end network)
  (or (reverse (depth-first-search end (list start) network))
      (if (eql start end) (list start) nil)))

(defun depth-first-search (end current network)
  (do ((best nil (longest best (get-path end (car neighbors) current best network)))
       (neighbors (cdr (assoc (car current) network)) (cdr neighbors)))
      ((null neighbors) best)))

(defun get-path (end neighbors current best network)
  (let ((path (if neighbors (cons neighbors current) nil)))
    (cond
      ((null path) nil)
      ((is-a-good-cycle end path) path)
      ((eql (car path) end) path)
      ((member (car path) (cdr path)) best)
      (t (depth-first-search end path network)))))

(defun is-a-good-cycle (end current)
  (and (eql (car current) end)
       (ending-finder current end)))

(defun ending-finder (current end)
  (eql end (car (last current))))

(defun longest (current best)
  (if (> (length current) (length best)) current best))
