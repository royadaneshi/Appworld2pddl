(define (problem task-cdaaea5-1)
  (:domain appworld-cdaaea5-1)
  (:objects
    matthew - person
    matthew-blac-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-item-1 query-item-2 query-item-3 query-item-4 query-item-5 query-item-6 query-item-7 query-item-8 query-item-9 query-item-10 - query
    amazon-shopping-list-note - note
    item-1 item-2 item-3 item-4 item-5 item-6 item-7 item-8 item-9 item-10 - item
    product-item-1 product-item-2 product-item-3 product-item-4 product-item-5 product-item-6 product-item-7 product-item-8 product-item-9 product-item-10 - product
    address-home - address
    amazon-payment-card - payment-card
    quantity-1 - quantity
  )
  (:init
    (credential-of-app simple-note matthew-blac-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon matthew-blac-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query amazon-shopping-list-note query-amazon-shopping-list)
    (shopping-item item-1)
    (shopping-item item-2)
    (shopping-item item-3)
    (shopping-item item-4)
    (shopping-item item-5)
    (shopping-item item-6)
    (shopping-item item-7)
    (shopping-item item-8)
    (shopping-item item-9)
    (shopping-item item-10)
    (query-for item-1 query-item-1)
    (query-for item-2 query-item-2)
    (query-for item-3 query-item-3)
    (query-for item-4 query-item-4)
    (query-for item-5 query-item-5)
    (query-for item-6 query-item-6)
    (query-for item-7 query-item-7)
    (query-for item-8 query-item-8)
    (query-for item-9 query-item-9)
    (query-for item-10 query-item-10)
    (product-for item-1 product-item-1)
    (product-for item-2 product-item-2)
    (product-for item-3 product-item-3)
    (product-for item-4 product-item-4)
    (product-for item-5 product-item-5)
    (product-for item-6 product-item-6)
    (product-for item-7 product-item-7)
    (product-for item-8 product-item-8)
    (product-for item-9 product-item-9)
    (product-for item-10 product-item-10)
    (is-home address-home))
  (:goal (and
    (order-placed)
    (ordered-to address-home)
    (in-cart product-item-1)
    (in-cart product-item-2)
    (in-cart product-item-3)
    (in-cart product-item-4)
    (in-cart product-item-5)
    (in-cart product-item-6)
    (in-cart product-item-7)
    (in-cart product-item-8)
    (in-cart product-item-9)
    (in-cart product-item-10)
    (task-completed)))
)
