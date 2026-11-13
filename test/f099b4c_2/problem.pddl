(define (problem task-f099b4c-2)
  (:domain appworld-f099b4c-2)
  (:objects
    denise - person
    deniseburch-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list - query
    shopping-list-note - note
    product-1 product-2 product-3 product-4 - product
    qty-1 qty-2 qty-3 qty-4 - quantity
    total-cost - amount
  )
  (:init
    (credential-of-app simple-note deniseburch-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon deniseburch-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (on-list shopping-list-note product-1)
    (on-list shopping-list-note product-2)
    (on-list shopping-list-note product-3)
    (on-list shopping-list-note product-4)
    (purchase-quantity product-1 qty-1)
    (purchase-quantity product-2 qty-2)
    (purchase-quantity product-3 qty-3)
    (purchase-quantity product-4 qty-4))
  (:goal (and
    (cart-cleared)
    (in-cart product-1 qty-1)
    (in-cart product-2 qty-2)
    (in-cart product-3 qty-3)
    (in-cart product-4 qty-4)
    (total-known)
    (found-total total-cost)
    (task-completed)))
)
