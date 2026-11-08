(define (problem task-099174d-1)
  (:domain appworld-099174d-1)
  (:objects
    joseph-weber - person
    joseph-webe-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list - query
    amazon-shopping-list-note - note
    list-product-1 list-product-2 list-product-3 - product
    qty-of-item-1 qty-of-item-2 qty-of-item-3 - quantity
    delivery-address - address
    payment-card-1 - payment-card)
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (query-matches query-amazon-shopping-list amazon-shopping-list-note)
    (shopping-list-note amazon-shopping-list-note)
    (on-shopping-list list-product-1 qty-of-item-1)
    (on-shopping-list list-product-2 qty-of-item-2)
    (on-shopping-list list-product-3 qty-of-item-3)
    (ships-to delivery-address))
  (:goal (and
    (in-cart list-product-1 qty-of-item-1)
    (in-cart list-product-2 qty-of-item-2)
    (in-cart list-product-3 qty-of-item-3)
    (order-placed)
    (task-completed)))
)
