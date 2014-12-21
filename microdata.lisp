(ql:quickload "cl-html-parse")

(defpackage microdata
  (:use :common-lisp :microdata-tests)
  (:export "CAMELIZE" "HYPHENATE"))

(in-package #:microdata)

(defun camelize (str &optional capitalize)
  (let ((space  #\ )
        (hyphen #\-))
    (cond
      ((eql capitalize t) (remove space (string-capitalize (substitute space hyphen str))))
      ((find hyphen str)  (remove hyphen (string-capitalize str :start (position hyphen str))))
      (t str))))

(defun camelize (str &optional capitalize)
  (let ((result (if (find #\- str)
                    (substitute #\  #\- (string-capitalize str :start (position #\- str)))
                    str)))
    (if (eql capitalize t) (remove #\  (string-capitalize result)) (remove #\  result))))



(defun hyphenate (str &optional (case :upper))
  (ecase case
         (:lower (string-downcase (hyphenate-helper str)))
         (:upper (string-upcase (hyphenate-helper str)))))

(defun hyphenate-helper (str)
  (let ((len (1- (length str))))
    (do* ((i 0 (1+ i))
          (prev (char str 0) (char str (1- i)))
          (current (char str 0) (char str i))
          (result (list current)
                  (if (and (lower-case-p prev) (upper-case-p current))
                      (list* current #\- result)
                      (cons current result))))
         ((eql i len) (coerce (reverse result) 'string)))))


(defun read-microdata (string)
  (find-items (net.html.parser:parse-html string)))

(defun microdata-url (url)
  (hyphenate
    (if (or (search "http://" url)
            (search "www." url))
        (subseq url (1+ (position #\/ url :from-end t)))
        url)))

(defun find-items (x)
  (and (consp x)
       (if (scope-p (car x))
           (list (cons (type-of-item (car x)) nil))
         (mapcan 'find-items x))))

(defun type-of-item (x)
  (let* ((package (find-package "ORG.SCHEMA"))
         (string (if (member :itemtype x)
                     (cadr (member :itemtype x))
                     "ITEM"))
         (symbol (intern (microdata-url string) package)))
    (export symbol package)
    symbol))

(defun scope-p (x)
  (and (consp x) (member :itemscope x)))
