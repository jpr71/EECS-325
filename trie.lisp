(in-package :cs325-user)
(ql:quickload "cs325")

(defpackage trie
  (:export make-trie trie-word trie-count trie-branch subtrie add-word read-words mapc-trie)
  (:use :common-lisp))

(in-package trie)

(defclass trie ()
  ((word   :accessor trie-word
           :initarg :word
           :initform nil)
   (count  :accessor trie-count
           :initarg :count
           :initform 0)
   (branch :accessor trie-branch
           :initarg :letters
           :initform nil)))

(defun make-trie ()
  (make-instance 'trie))

(defun subtrie-from-leaf (trie leaf)
  (cdr (assoc leaf (trie-branch trie))))

(defmethod trie-traverse :after (trie chars add-leaf)
  (when add-leaf (incf (trie-count trie))))

(defmethod trie-traverse (trie chars add-leaf)
  (if (null chars) trie
      (let ((child (subtrie-from-leaf trie (car chars))))
        (when (and (null child) add-leaf)
          (setf child (make-trie))
          (push (cons (car chars) child) (trie-branch trie)))
        (trie-traverse child (cdr chars) add-leaf))))

(defun subtrie (trie &rest chars)
  (trie-traverse trie chars nil))

(defun add-word (word trie)
  (let* ((chars (coerce word 'list))
         (subtrie (trie-traverse trie chars t)))
    (setf (trie-word subtrie) word)
    trie))

(defun read-words (file trie)
  (with-open-file (stream file)
                  (do ((ln (read-line stream nil) (read-line stream nil)))
                      ((null ln) trie)
                      (add-word ln trie))))

(defun mapc-trie (fn trie)
  (loop for (leaf . subtrie) in (trie-branch trie)
        do (funcall fn leaf subtrie)))
