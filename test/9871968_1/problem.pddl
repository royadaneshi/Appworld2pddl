(define (problem task-9871968-1)
  (:domain appworld-9871968-1)
  (:objects
    allison - person
    allison-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    wish-product-1 wish-product-2 wish-product-3 wish-product-4 wish-product-5 - product
    work-address home-address - address
    amazon-card-1 - payment-card
    count-0 count-1 count-2 count-3 count-4 count-5 - count
  )
  (:init
    (password-for amazon amazon-password)
    (zero-count count-0)
    (is-work-address work-address)
    (on-wish-list wish-product-1)
    (on-wish-list wish-product-2)
    (on-wish-list wish-product-3)
    (on-wish-list wish-product-4)
    (on-wish-list wish-product-5)
    (wish-remaining count-5)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3)
    (next-count count-3 count-4)
    (next-count count-4 count-5))
  (:goal (and
    (not (on-wish-list wish-product-1))
    (not (on-wish-list wish-product-2))
    (not (on-wish-list wish-product-3))
    (not (on-wish-list wish-product-4))
    (not (on-wish-list wish-product-5))
    (in-cart wish-product-1)
    (in-cart wish-product-2)
    (in-cart wish-product-3)
    (in-cart wish-product-4)
    (in-cart wish-product-5)
    (order-placed)
    (order-shipped-to work-address)
    (task-completed)))
)
