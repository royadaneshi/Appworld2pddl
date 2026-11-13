(define (problem task-cdaaea5-3)
  (:domain appworld-cdaaea5-3)
  (:objects
    jared - person
    jar-calhoun-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-item-1 query-item-2 query-item-3 query-item-4 query-item-5 query-item-6 query-item-7 - query
    sort-by-rating-desc - sort-key
    amazon-shopping-list-note - note
    item-1 item-2 item-3 item-4 item-5 item-6 item-7 - shopping-item
    best-product-item-1 best-product-item-2 best-product-item-3 best-product-item-4 best-product-item-5 best-product-item-6 best-product-item-7 - product
    quantity-1 - quantity
    home-address - address
    payment-card-1 - payment-card
    count-0 count-1 count-2 count-3 count-4 count-5 count-6 count-7 - count
  )
  (:init
    (credential-of-app simple-note jar-calhoun-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon jar-calhoun-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-search-query amazon-shopping-list-note query-amazon-shopping-list)
    (query-for item-1 query-item-1)
    (query-for item-2 query-item-2)
    (query-for item-3 query-item-3)
    (query-for item-4 query-item-4)
    (query-for item-5 query-item-5)
    (query-for item-6 query-item-6)
    (query-for item-7 query-item-7)
    (product-for-item item-1 best-product-item-1)
    (product-for-item item-2 best-product-item-2)
    (product-for-item item-3 best-product-item-3)
    (product-for-item item-4 best-product-item-4)
    (product-for-item item-5 best-product-item-5)
    (product-for-item item-6 best-product-item-6)
    (product-for-item item-7 best-product-item-7)
    (is-home-address home-address)
    (cart-count count-0)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (succ count-3 count-4)
    (succ count-4 count-5)
    (succ count-5 count-6)
    (succ count-6 count-7)
    (required-count count-7))
  (:goal (and
    (order-placed)
    (task-completed))))
