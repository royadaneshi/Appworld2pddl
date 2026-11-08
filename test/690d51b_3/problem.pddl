(define (problem task-690d51b-3)
  (:domain appworld-690d51b-3)
  (:objects
    hunter-weaver - person
    hun-weaver-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-cooling-fan - query
    type-cooling-fan - product-type
    price-20 - price
    cooling-fan - product
    home-address - address
    amazon-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (product-of-type cooling-fan type-cooling-fan)
    (product-within-price cooling-fan price-20)
    (is-home home-address))
  (:goal (and (order-placed cooling-fan home-address) (task-completed)))
)
