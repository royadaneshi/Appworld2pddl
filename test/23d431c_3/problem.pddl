(define (problem task-23d431c-3)
  (:domain appworld-23d431c-3)
  (:objects
    chelsea - person
    chelsea-burch-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-watch - query
    watch - product-type
    max-price-110 - price-limit
    qty-1 - quantity
    past-order-1 - order
    past-product-1 - product
    trusted-seller-1 - seller
    watch-product - product
    home-address - address
    supervisor-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (is-past-order past-order-1)
    (contains-product past-order-1 past-product-1)
    (seller-of past-product-1 trusted-seller-1)
    (query-for query-watch watch)
    (of-type watch-product watch)
    (price-within watch-product max-price-110)
    (seller-of watch-product trusted-seller-1)
  )
  (:goal (and (ordered watch-product qty-1) (task-completed)))
)
