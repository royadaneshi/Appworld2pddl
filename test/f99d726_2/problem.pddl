(define (problem task-f99d726-2)
  (:domain appworld-f99d726-2)
  (:objects
    miranda-weber - person
    mir-powe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-sweater replacement-sweater - product
    last-sweater-order - order
    return-deliverer - deliverer
    payment-card-default - payment-card
    home-address - address
    quantity-1 - quantity
    flag-true - flag)
  (:init
    (password-for amazon amazon-password)
    (is-last-sweater last-sweater)
    (ordered-in last-sweater last-sweater-order)
    (is-replacement replacement-sweater))
  (:goal (and
    (return-initiated last-sweater-order last-sweater)
    (order-placed replacement-sweater quantity-1)
    (task-completed)))
)
