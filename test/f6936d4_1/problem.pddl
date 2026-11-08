(define (problem task-f6936d4-1)
  (:domain appworld-f6936d4-1)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    kite sleeping-pad - product-type
    kite-product sleeping-pad-product - product
    quantity-3 - quantity
    home-address - address
    payment-card-1 - payment-card)
  (:init
    (password-for amazon amazon-password)
    (product-type-of kite-product kite)
    (product-type-of sleeping-pad-product sleeping-pad)
    (needs-quantity kite-product quantity-3)
    (needs-quantity sleeping-pad-product quantity-3))
  (:goal (and
    (order-placed)
    (ordered kite-product quantity-3)
    (ordered sleeping-pad-product quantity-3)
    (task-completed))))
