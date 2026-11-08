(define (problem task-9871968-1)
  (:domain appworld-9871968-1)
  (:objects
    allison - person
    allison-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    wish-product-1 wish-product-2 - product
    work-address home-address - address
    amazon-card-1 - payment-card
    count-0 count-1 count-2 - count)
  (:init
    (password-for amazon amazon-password)
    (on-wish-list wish-product-1)
    (on-wish-list wish-product-2)
    (wish-remaining count-2)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (zero-count count-0)
    (is-work-address work-address))
  (:goal (and
    (not (on-wish-list wish-product-1))
    (not (on-wish-list wish-product-2))
    (in-cart wish-product-1)
    (in-cart wish-product-2)
    (order-placed)
    (order-shipped-to work-address)
    (task-completed)))
)
