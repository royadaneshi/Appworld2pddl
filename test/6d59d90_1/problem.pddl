(define (problem task-6d59d90-1)
  (:domain appworld-6d59d90-1)
  (:objects
    nancy-ritter - person
    nan-ritt-at-gmail-com - username
    amazon-password venmo-password - password
    amazon-token venmo-token - token
    query-face-shield - query
    cheapest-face-shield - product
    clear-cart-first-true - flag
    amount-order-total - amount
    nancy-home-address - address
    amazon-card-1 - amazon-card
    venmo-card-1 - venmo-card)
  (:init
    (username-for amazon nan-ritt-at-gmail-com)
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (token-of amazon amazon-token)
    (token-of venmo venmo-token)
    (product-query cheapest-face-shield query-face-shield)
    (cart-total-of cheapest-face-shield amount-order-total)
    (home-address nancy-home-address)
    (same-card amazon-card-1 venmo-card-1))
  (:goal (and
    (order-placed cheapest-face-shield nancy-home-address)
    (transferred-to-card amount-order-total venmo-card-1)
    (task-completed))))
