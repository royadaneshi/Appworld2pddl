(define (problem task-cdaaea5-2)
  (:domain appworld-cdaaea5-2)
  (:objects
    cesar-maldonado - person
    ce-maldonado-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-list-item-1 query-list-item-2 - query
    shopping-list-note - note
    list-item-1 list-item-2 - list-item
    best-product-item-1 best-product-item-2 - product
    work-address - address
    payment-card-1 - payment-card
    amazon-order - order
    count-0 count-1 count-2 - count)
  (:init
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-for-query query-amazon-shopping-list shopping-list-note)
    (item-in-note list-item-1 shopping-list-note)
    (item-in-note list-item-2 shopping-list-note)
    (query-for-item list-item-1 query-list-item-1)
    (query-for-item list-item-2 query-list-item-2)
    (best-product list-item-1 best-product-item-1)
    (best-product list-item-2 best-product-item-2)
    (is-work-address work-address)
    (cart-count count-0)
    (count-succ count-0 count-1)
    (count-succ count-1 count-2)
    (list-size count-2))
  (:goal (and
    (order-placed amazon-order)
    (order-shipped-to amazon-order work-address)
    (task-completed))))
