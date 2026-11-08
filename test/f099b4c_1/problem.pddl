(define (problem task-f099b4c-1)
  (:domain appworld-f099b4c-1)
  (:objects
    ja-solomon-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-shopping-list - query
    shopping-list-note - note
    listed-product-1 listed-product-2 listed-product-3 - product
    quantity-2 quantity-1 - quantity
    total-cost - cost
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-matches shopping-list-note query-shopping-list)
    (on-list listed-product-1 shopping-list-note)
    (on-list listed-product-2 shopping-list-note)
    (on-list listed-product-3 shopping-list-note)
    (purchasable listed-product-1 quantity-2)
    (purchasable listed-product-2 quantity-1)
    (unavailable listed-product-3)
  )
  (:goal (and
    (cart-cleared)
    (in-cart listed-product-1 quantity-2)
    (in-cart listed-product-2 quantity-1)
    (availability-known listed-product-3)
    (found-total-cost total-cost)
    (cart-cost-current)
    (task-completed)
  ))
)
