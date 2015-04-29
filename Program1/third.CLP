(deffacts third
(has hoofs)
(does give milk)
(has white color)
(has black stripes))

(defrule rule-1
(has hair)
=>
(assert (is-a mammal)))

(defrule rule-2
(does give milk)
=>
(assert (is-a mammal)))

(defrule rule-3
(has feathers)
=>
(assert (is-a bird)))

(defrule rule-4
(does fly)
(does lay egg)
=>
(assert (is-a bird)))

(defrule rule-5
(is-a mammal)
(does eat meat)
=>
(assert (is-a carnivore)))

(defrule rule-6
(is-a mammal)
(has pointed teeth)
(has claws)
(has eyes point forward)
=>
(assert (is-a carnivore)))

(defrule rule-7
(is-a mammal)
(has hoofs)
=>
(assert (is-a ungulate)))

(defrule rule-8
(is-a mammal)
(does chew cud)
=>
(assert (is-a ungulate))
(assert (has even toes)))

(defrule rule-9
(is-a carnivore)
(has tawny color)
(has dark spots)
=>
(assert (is-a cheetah)))

(defrule rule-10
(is-a carnivore)
(has tawny color)
(has black strips)
=>
(assert (is-a tiger)))

(defrule rule-11
(is-a ungulate)
(has long legs)
(has long neck)
(has tawny color)
(has long dark spots)
=>
(assert (is-a giraffe)))

(defrule rule-12
(is-a ungulate)
(has white color)
(has black stripes)
=>
(assert (is-a zebra)))

(defrule rule-13
(is-a bird)
(does-not fly)
(has long legs)
(has long neck)
(has black-white color)
=>
(assert (is-a ostrich)))

(defrule rule-14
(is-a bird)
(does swim)
(has black-white color)
=>
(assert (is-a penguin)))

(defrule rule-15
(is-a bird)
(does fly good)
=>
(assert (is-a albatross)))