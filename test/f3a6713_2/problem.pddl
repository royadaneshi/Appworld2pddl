(define (problem task-f3a6713-2)
  (:domain appworld-f3a6713-2)
  (:objects
    chris-mccoy - person
    chris-mcco-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-camping query-remaining-item-1 query-remaining-item-2 query-remaining-item-3 query-remaining-item-4 - query
    camping-checklist-thread - email-thread
    best-remaining-item-1 best-remaining-item-2 best-remaining-item-3 best-remaining-item-4 - product
    quantity-remaining-item-1 quantity-remaining-item-2 quantity-remaining-item-3 quantity-remaining-item-4 - quantity
    chris-payment-card - payment-card
    chris-address - address
  )
  (:init
    (credential-of-app gmail chris-mcco-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app amazon chris-mcco-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-query camping-checklist-thread query-camping)
    (query-for remaining-item-1 query-remaining-item-1)
    (query-for remaining-item-2 query-remaining-item-2)
    (query-for remaining-item-3 query-remaining-item-3)
    (query-for remaining-item-4 query-remaining-item-4)
    (product-for remaining-item-1 best-remaining-item-1)
    (product-for remaining-item-2 best-remaining-item-2)
    (product-for remaining-item-3 best-remaining-item-3)
    (product-for remaining-item-4 best-remaining-item-4)
    (needed-quantity remaining-item-1 quantity-remaining-item-1)
    (needed-quantity remaining-item-2 quantity-remaining-item-2)
    (needed-quantity remaining-item-3 quantity-remaining-item-3)
    (needed-quantity remaining-item-4 quantity-remaining-item-4))
  (:goal (and
    (order-placed)
    (added-to-cart remaining-item-1)
    (added-to-cart remaining-item-2)
    (added-to-cart remaining-item-3)
    (added-to-cart remaining-item-4)
    (task-completed)))
)
