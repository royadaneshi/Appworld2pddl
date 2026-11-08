(define (problem task-099174d-2)
  (:domain appworld-099174d-2)
  (:objects
    kathryn - person
    kathrynmaldonado-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-product-1 query-product-2 - query
    amazon-shopping-list-note - note
    list-product-1 list-product-2 - product
    qty-item-1 qty-item-2 - quantity
    delivery-address - address
    payment-card-1 - payment-card)
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query query-amazon-shopping-list amazon-shopping-list-note)
    (shopping-list-note amazon-shopping-list-note)
    (on-list list-product-1 qty-item-1)
    (on-list list-product-2 qty-item-2)
    (product-query list-product-1 query-product-1)
    (product-query list-product-2 query-product-2)
    (note-delivery-address delivery-address))
  (:goal (and
    (added-to-cart list-product-1 qty-item-1)
    (added-to-cart list-product-2 qty-item-2)
    (order-placed delivery-address)
    (task-completed)))
)
