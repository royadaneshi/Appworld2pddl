(define (problem task-cdaaea5-2)
  (:domain appworld-cdaaea5-2)
  (:objects
    cesar-maldonado - person
    ce-maldonado-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-shopping-list query-list-item-1 query-list-item-2 query-list-item-3 query-list-item-4 query-list-item-5 query-list-item-6 query-list-item-7 - query
    shopping-list-note - note
    list-item-1 list-item-2 list-item-3 list-item-4 list-item-5 list-item-6 list-item-7 - list-item
    best-product-item-1 best-product-item-2 best-product-item-3 best-product-item-4 best-product-item-5 best-product-item-6 best-product-item-7 - product
    work-address - address
    payment-card-1 - payment-card
    amazon-order - order
    count-0 count-1 count-2 count-3 count-4 count-5 count-6 count-7 - count
  )
  (:init
    (credential-of-app simple-note ce-maldonado-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon ce-maldonado-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-for-query query-amazon-shopping-list shopping-list-note)
    (item-in-note list-item-1 shopping-list-note)
    (item-in-note list-item-2 shopping-list-note)
    (item-in-note list-item-3 shopping-list-note)
    (item-in-note list-item-4 shopping-list-note)
    (item-in-note list-item-5 shopping-list-note)
    (item-in-note list-item-6 shopping-list-note)
    (item-in-note list-item-7 shopping-list-note)
    (query-for-item list-item-1 query-list-item-1)
    (query-for-item list-item-2 query-list-item-2)
    (query-for-item list-item-3 query-list-item-3)
    (query-for-item list-item-4 query-list-item-4)
    (query-for-item list-item-5 query-list-item-5)
    (query-for-item list-item-6 query-list-item-6)
    (query-for-item list-item-7 query-list-item-7)
    (best-product list-item-1 best-product-item-1)
    (best-product list-item-2 best-product-item-2)
    (best-product list-item-3 best-product-item-3)
    (best-product list-item-4 best-product-item-4)
    (best-product list-item-5 best-product-item-5)
    (best-product list-item-6 best-product-item-6)
    (best-product list-item-7 best-product-item-7)
    (is-work-address work-address)
    (cart-count count-0)
    (count-succ count-0 count-1)
    (count-succ count-1 count-2)
    (count-succ count-2 count-3)
    (count-succ count-3 count-4)
    (count-succ count-4 count-5)
    (count-succ count-5 count-6)
    (count-succ count-6 count-7)
    (list-size count-7))
  (:goal (and
    (order-placed amazon-order)
    (order-shipped-to amazon-order work-address)
    (task-completed))))
