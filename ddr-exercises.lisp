(in-package #:ddr-tests)

(defparameter *member-kb*
  '((member ?x (cons ?x ?lst))
    (<- (member ?x (cons ?y ?lst))
        (member ?x ?lst))))

(defparameter *all-different-kb*
  '((-> (all-different (cons ?l3 (cons ?l2 ?l1)))
        (all-different (cons ?l2 ?l1))
        (all-different (cons ?l3 ?l1))
        (different ?l3 ?l2))
    (-> (different ?x ?y) (different ?y ?x))))

(in-package :ddr-tests)


(defparameter *map-color-kb*
  '(
    (color red)
    (color blue)
    (color green)
    (color yellow)

    (-> (all-different (cons ?x (cons ?a ?l))) (different ?x ?a)
                                               (all-different (cons ?x ?l))
                                               (all-different (cons ?a ?l)))
    (-> (different ?x ?y) (different ?y ?x))

    (all-different (cons red (cons blue (cons green (cons yellow nil)))))

    (<- (colors-for map1 ?a ?b ?c ?d)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?b ?c)
        (different ?b ?d)
        (different ?c ?d))


    (<- (colors-for map2 ?a ?b ?c ?d ?e)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (color ?e)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?a ?e)
        (different ?b ?c)
        (different ?b ?e)
        (different ?c ?d)
        (different ?c ?e)
        (different ?d ?e))

    (<- (colors-for map3 ?a ?b ?c ?d ?e ?f)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (color ?e)
        (color ?f)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?a ?e)
        (different ?a ?f)
        (different ?b ?c)
        (different ?b ?d)
        (different ?b ?e)
        (different ?c ?d)
        (different ?d ?e)
        (different ?d ?f)
        (different ?e ?f))

    ))

(run-tests)
