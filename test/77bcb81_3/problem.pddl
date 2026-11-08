(define (problem task-77bcb81-3)
  (:domain appworld-77bcb81-3)
  (:objects
    jordan-harrison - person
    jo-harr-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    home-address work-address - address
    payment-card-1 - payment-card
    wish-product-1 wish-product-2 wish-product-3 - product)
  (:init
    (password-for amazon amazon-password)
    (is-home-address home-address)
    (in-wishlist wish-product-1)
    (in-wishlist wish-product-2)
    (in-wishlist wish-product-3))
  (:goal (and
    (in-cart wish-product-1)
    (in-cart wish-product-2)
    (in-cart wish-product-3)
    (order-placed)
    (ordered-to-home)
    (task-completed))))
