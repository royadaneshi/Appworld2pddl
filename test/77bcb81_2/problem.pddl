(define (problem task-77bcb81-2)
  (:domain appworld-77bcb81-2)
  (:objects
    norman-smith - person
    normansmit-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cart-product-1 - product
    wish-product-1 wish-product-2 wish-product-3 - product
    work-address home-address - address
    payment-card-1 - payment-card)
  (:init
    (username-for amazon normansmit-at-gmail-com)
    (password-for amazon amazon-password)
    (in-cart cart-product-1)
    (in-wish-list wish-product-1)
    (in-wish-list wish-product-2)
    (in-wish-list wish-product-3))
  (:goal (and
    (in-cart cart-product-1)
    (in-cart wish-product-1)
    (in-cart wish-product-2)
    (in-cart wish-product-3)
    (order-placed-to work-address)
    (task-completed)))
)
