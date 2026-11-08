(define (problem task-cdaaea5-3)
  (:domain appworld-cdaaea5-3)
  (:objects
    jared - person
    jar-calhoun-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-item-1 query-item-2 - query
    sort-by-rating-desc - sort-key
    amazon-shopping-list-note - note
    item-1 item-2 - shopping-item
    best-product-item-1 best-product-item-2 - product
    quantity-1 - quantity
    home-address - address
    payment-card-1 - payment-card
    count-0 count-1 count-2 - count)
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-search-query amazon-shopping-list-note query-amazon-shopping-list)
    (query-for item-1 query-item-1)
    (query-for item-2 query-item-2)
    (product-for-item item-1 best-product-item-1)
    (product-for-item item-2 best-product-item-2)
    (is-home-address home-address)
    (cart-count count-0)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (required-count count-2))
  (:goal (and (order-placed) (task-completed))))
