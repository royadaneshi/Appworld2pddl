(define (problem task-7d26579-1)
  (:domain appworld-7d26579-1)
  (:objects
    matthew - person
    user-matthew-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    matthew-blac-at-gmail-com - email
    last-tshirt-order - order
    tshirt-product - product
    my-tshirt-question - question
    answer-yes answer-no - answer)
  (:init
    (username-for amazon user-matthew-blac-at-gmail-com)
    (password-for amazon amazon-password)
    (supervisor-email matthew matthew-blac-at-gmail-com)
    (target-order last-tshirt-order)
    (order-contains last-tshirt-order tshirt-product)
    (is-tshirt tshirt-product)
    (asked matthew my-tshirt-question tshirt-product))
  (:goal (and (answer-known) (task-completed)))
)
