(define (problem task-099174d-2)
  (:domain appworld-099174d-2)
  (:objects
    kathryn - person
    kathrynmaldonado-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    amazon-shopping-list-note - note
    delivery-address - address
    payment-card-1 - payment-card
    list-product-1 list-product-2 list-product-3 list-product-4 list-product-5 list-product-6 - product
    qty-item-1 qty-item-2 qty-item-3 - quantity
    query-amazon-shopping-list query-product-1 query-product-2 query-product-3 query-product-4 query-product-5 query-product-6 - query
  )
  (:init
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query query-amazon-shopping-list amazon-shopping-list-note)
    (shopping-list-note amazon-shopping-list-note)
    (note-delivery-address delivery-address)
    (on-list list-product-1 qty-item-1)
    (on-list list-product-2 qty-item-1)
    (on-list list-product-3 qty-item-2)
    (on-list list-product-4 qty-item-2)
    (on-list list-product-5 qty-item-2)
    (on-list list-product-6 qty-item-3)
    (product-query list-product-1 query-product-1)
    (product-query list-product-2 query-product-2)
    (product-query list-product-3 query-product-3)
    (product-query list-product-4 query-product-4)
    (product-query list-product-5 query-product-5)
    (product-query list-product-6 query-product-6))
  (:goal (and
    (added-to-cart list-product-1 qty-item-1)
    (added-to-cart list-product-2 qty-item-1)
    (added-to-cart list-product-3 qty-item-2)
    (added-to-cart list-product-4 qty-item-2)
    (added-to-cart list-product-5 qty-item-2)
    (added-to-cart list-product-6 qty-item-3)
    (order-placed delivery-address)
    (task-completed)))
)
