(define (problem task-f099b4c-2)
  (:domain appworld-f099b4c-2)
  (:objects
    denise - person
    deniseburch-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list - query
    shopping-list-note - note
    product-1 product-2 product-3 - product
    qty-1 qty-2 qty-3 - quantity
    total-cost - amount)
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (on-list shopping-list-note product-1)
    (on-list shopping-list-note product-2)
    (on-list shopping-list-note product-3)
    (purchase-quantity product-1 qty-1)
    (purchase-quantity product-2 qty-2)
    (purchase-quantity product-3 qty-3))
  (:goal (and
    (cart-cleared)
    (in-cart product-1 qty-1)
    (in-cart product-2 qty-2)
    (in-cart product-3 qty-3)
    (total-known)
    (found-total total-cost)
    (task-completed)))
)
