(define (problem task-f99d726-1)
  (:domain appworld-f99d726-1)
  (:objects
    sierra - person
    siwhit-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-tshirt replacement-tshirt - product
    last-tshirt-order - order
    return-deliverer - deliverer
    quantity-1 - quantity
    true-flag - flag
    amazon-payment-card - payment-card
    amazon-address - address)
  (:init
    (username-for amazon siwhit-at-gmail-com)
    (password-for amazon amazon-password)
    (last-tshirt-purchase last-tshirt last-tshirt-order)
    (next-size-variant last-tshirt replacement-tshirt)
    (unit-quantity quantity-1)
    (flag-true true-flag))
  (:goal (and
    (return-initiated last-tshirt last-tshirt-order)
    (ordered replacement-tshirt)
    (task-completed))))
