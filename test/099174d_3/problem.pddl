(define (problem task-099174d-3)
  (:domain appworld-099174d-3)
  (:objects
    allison - person
    allison-calhoun-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    amazon-shopping-list-note - note
    delivery-address - address
    amazon-payment-card - payment-card
    new-order - order
    shopping-list-item-1 shopping-list-item-2 shopping-list-item-3 shopping-list-item-4 shopping-list-item-5 shopping-list-item-6 shopping-list-item-7 - product
    quantity-item-1 quantity-item-2 quantity-item-3 - quantity
    query-amazon-shopping-list query-item-name-1 query-item-name-2 query-item-name-3 query-item-name-4 query-item-name-5 query-item-name-6 query-item-name-7 - query
  )
  (:init
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query amazon-shopping-list-note query-amazon-shopping-list)
    (note-address amazon-shopping-list-note delivery-address)
    (listed-in shopping-list-item-1 amazon-shopping-list-note)
    (listed-in shopping-list-item-2 amazon-shopping-list-note)
    (listed-in shopping-list-item-3 amazon-shopping-list-note)
    (listed-in shopping-list-item-4 amazon-shopping-list-note)
    (listed-in shopping-list-item-5 amazon-shopping-list-note)
    (listed-in shopping-list-item-6 amazon-shopping-list-note)
    (listed-in shopping-list-item-7 amazon-shopping-list-note)
    (product-query shopping-list-item-1 query-item-name-1)
    (product-query shopping-list-item-2 query-item-name-2)
    (product-query shopping-list-item-3 query-item-name-3)
    (product-query shopping-list-item-4 query-item-name-4)
    (product-query shopping-list-item-5 query-item-name-5)
    (product-query shopping-list-item-6 query-item-name-6)
    (product-query shopping-list-item-7 query-item-name-7)
    (wanted-quantity shopping-list-item-1 quantity-item-3)
    (wanted-quantity shopping-list-item-2 quantity-item-2)
    (wanted-quantity shopping-list-item-3 quantity-item-1)
    (wanted-quantity shopping-list-item-4 quantity-item-3)
    (wanted-quantity shopping-list-item-5 quantity-item-2)
    (wanted-quantity shopping-list-item-6 quantity-item-1)
    (wanted-quantity shopping-list-item-7 quantity-item-3))
  (:goal (and
    (order-placed new-order)
    (order-address new-order delivery-address)
    (added-to-cart shopping-list-item-1 quantity-item-3)
    (added-to-cart shopping-list-item-2 quantity-item-2)
    (added-to-cart shopping-list-item-3 quantity-item-1)
    (added-to-cart shopping-list-item-4 quantity-item-3)
    (added-to-cart shopping-list-item-5 quantity-item-2)
    (added-to-cart shopping-list-item-6 quantity-item-1)
    (added-to-cart shopping-list-item-7 quantity-item-3)
    (checkout-done)
    (task-completed)))
)
