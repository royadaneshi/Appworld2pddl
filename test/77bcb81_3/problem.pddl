(define (problem task-77bcb81-3)
  (:domain appworld-77bcb81-3)
  (:objects
    jordan-harrison - person
    jo-harr-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    home-address work-address - address
    payment-card-1 - payment-card
    wish-product-1 wish-product-2 wish-product-3 wish-product-4 wish-product-5 wish-product-6 wish-product-7 wish-product-8 wish-product-9 wish-product-10 - product
  )
  (:init
    (password-for amazon amazon-password)
    (is-home-address home-address)
    (in-wishlist wish-product-6)
    (in-wishlist wish-product-7)
    (in-wishlist wish-product-8)
    (in-wishlist wish-product-9)
    (in-wishlist wish-product-10))
  (:goal (and
    (in-cart wish-product-6)
    (in-cart wish-product-7)
    (in-cart wish-product-8)
    (in-cart wish-product-9)
    (in-cart wish-product-10)
    (order-placed)
    (ordered-to-home)
    (task-completed))))
