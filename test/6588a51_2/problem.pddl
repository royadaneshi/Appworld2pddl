(define (problem task-6588a51-2)
  (:domain appworld-6588a51-2)
  (:objects
    norman - person
    normansmit-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    latest-sweater-order - order
    last-sweater - product
    sweater - product-type
    question-detergents - question)
  (:init
    (password-for amazon amazon-password)
    (wanted-type sweater)
    (latest-order-of-type latest-sweater-order sweater)
    (in-order last-sweater latest-sweater-order)
    (has-product-type last-sweater sweater))
  (:goal (and
    (question-posted last-sweater question-detergents)
    (task-completed)))
)
