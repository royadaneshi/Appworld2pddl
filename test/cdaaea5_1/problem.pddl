(define (problem task-cdaaea5-1)
  (:domain appworld-cdaaea5-1)
  (:objects
    matthew - person
    matthew-blac-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-item-1 query-item-2 - query
    amazon-shopping-list-note - note
    item-1 item-2 - item
    product-item-1 product-item-2 - product
    address-home - address
    amazon-payment-card - payment-card
    quantity-1 - quantity
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query amazon-shopping-list-note query-amazon-shopping-list)
    (shopping-item item-1)
    (shopping-item item-2)
    (query-for item-1 query-item-1)
    (query-for item-2 query-item-2)
    (product-for item-1 product-item-1)
    (product-for item-2 product-item-2)
    (is-home address-home)
  )
  (:goal (and
    (order-placed)
    (ordered-to address-home)
    (in-cart product-item-1)
    (in-cart product-item-2)
    (task-completed)
  ))
)
