(define (problem task-f099b4c-3)
  (:domain appworld-f099b4c-3)
  (:objects
    alex - person
    alexwhite-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-list-product-1 query-list-product-2 query-list-product-3 query-list-product-4 - query
    shopping-list-note - note
    list-product-1 list-product-2 list-product-3 list-product-4 - product
    qty-product-1 qty-product-2 qty-product-3 qty-product-4 - quantity
    total-cost - amount
  )
  (:init
    (username-for simple-note alexwhite-at-gmail-com)
    (username-for amazon alexwhite-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (token-of simple-note simple-note-token)
    (token-of amazon amazon-token)
    (note-matches query-amazon-shopping-list shopping-list-note)
    (is-shopping-list shopping-list-note)
    (product-query list-product-1 query-list-product-1)
    (product-query list-product-2 query-list-product-2)
    (product-query list-product-3 query-list-product-3)
    (product-query list-product-4 query-list-product-4)
    (purchasable list-product-1 qty-product-1)
    (purchasable list-product-2 qty-product-2)
    (purchasable list-product-3 qty-product-3)
    (purchasable list-product-4 qty-product-4)
    (cart-total total-cost))
  (:goal (and
    (availability-known list-product-1)
    (availability-known list-product-2)
    (availability-known list-product-3)
    (availability-known list-product-4)
    (cart-cleared)
    (in-cart list-product-1 qty-product-1)
    (in-cart list-product-2 qty-product-2)
    (in-cart list-product-3 qty-product-3)
    (in-cart list-product-4 qty-product-4)
    (cart-total-known)
    (task-completed)))
)
