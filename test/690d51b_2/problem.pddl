(define (problem task-690d51b-2)
  (:domain appworld-690d51b-2)
  (:objects
    katherine - person
    ka-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-coffee-maker - query
    type-coffee-maker - product-type
    price-150 - price
    coffee-maker-product - product
    quantity-1 - quantity
    true-flag - flag
    work-address - address
    amazon-payment-card - payment-card
    coffee-maker-order - order)
  (:init
    (username-for amazon ka-ball-at-gmail-com)
    (password-for amazon amazon-password)
    (search-matches query-coffee-maker type-coffee-maker)
    (product-matches coffee-maker-product type-coffee-maker price-150)
    (budget price-150)
    (unit-quantity quantity-1)
    (flag-true true-flag)
    (is-work-address work-address))
  (:goal (and
    (order-placed coffee-maker-order coffee-maker-product quantity-1 work-address)
    (task-completed))))
