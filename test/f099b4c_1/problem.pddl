(define (problem task-f099b4c-1)
  (:domain appworld-f099b4c-1)
  (:objects
    ja-solomon-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-shopping-list - query
    shopping-list-note - note
    listed-product-1 listed-product-2 listed-product-3 listed-product-4 listed-product-5 - product
    quantity-product-1 quantity-product-2 quantity-product-3 quantity-product-4 quantity-product-5 - quantity
    total-cost - cost
  )
  (:init
    (credential-of-app simple-note ja-solomon-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon ja-solomon-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-matches shopping-list-note query-shopping-list)
    (on-list listed-product-1 shopping-list-note)
    (on-list listed-product-2 shopping-list-note)
    (on-list listed-product-3 shopping-list-note)
    (on-list listed-product-4 shopping-list-note)
    (on-list listed-product-5 shopping-list-note)
    (purchasable listed-product-1 quantity-product-1)
    (purchasable listed-product-2 quantity-product-2)
    (purchasable listed-product-3 quantity-product-3)
    (purchasable listed-product-4 quantity-product-4)
    (purchasable listed-product-5 quantity-product-5))
  (:goal (and
    (cart-cleared)
    (in-cart listed-product-1 quantity-product-1)
    (in-cart listed-product-2 quantity-product-2)
    (in-cart listed-product-3 quantity-product-3)
    (in-cart listed-product-4 quantity-product-4)
    (in-cart listed-product-5 quantity-product-5)
    (found-total-cost total-cost)
    (cart-cost-current)
    (task-completed)))
)
