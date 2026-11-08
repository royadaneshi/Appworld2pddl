(define (problem task-099174d-3)
  (:domain appworld-099174d-3)
  (:objects
    allison - person
    allison-calhoun-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-item-1-name query-item-2-name - query
    amazon-shopping-list-note - note
    shopping-list-item-1 shopping-list-item-2 - product
    quantity-item-1 quantity-item-2 - quantity
    delivery-address - address
    amazon-payment-card - payment-card
    new-order - order
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query amazon-shopping-list-note query-amazon-shopping-list)
    (listed-in shopping-list-item-1 amazon-shopping-list-note)
    (listed-in shopping-list-item-2 amazon-shopping-list-note)
    (product-query shopping-list-item-1 query-item-1-name)
    (product-query shopping-list-item-2 query-item-2-name)
    (wanted-quantity shopping-list-item-1 quantity-item-1)
    (wanted-quantity shopping-list-item-2 quantity-item-2)
    (note-address amazon-shopping-list-note delivery-address)
  )
  (:goal (and
    (order-placed new-order)
    (order-address new-order delivery-address)
    (ordered new-order shopping-list-item-1 quantity-item-1)
    (ordered new-order shopping-list-item-2 quantity-item-2)
    (checkout-done)
    (task-completed)
  ))
)
