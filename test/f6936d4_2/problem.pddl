(define (problem task-f6936d4-2)
  (:domain appworld-f6936d4-2)
  (:objects
    jamie - person
    jamie-solomon-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-fishing-rod query-disinfecting-wipes - query
    fishing-rod disinfecting-wipes - product-type
    fishing-rod-product disinfecting-wipes-product - product
    quantity-4 - quantity
    home-address - address
    payment-card-1 - payment-card
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (query-for query-fishing-rod fishing-rod)
    (query-for query-disinfecting-wipes disinfecting-wipes)
    (product-of-type fishing-rod-product fishing-rod)
    (product-of-type disinfecting-wipes-product disinfecting-wipes)
    (is-home home-address))
  (:goal (and
    (order-placed order-1)
    (ordered order-1 fishing-rod-product quantity-4)
    (ordered order-1 disinfecting-wipes-product quantity-4)
    (task-completed))))
