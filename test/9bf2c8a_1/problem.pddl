(define (problem task-9bf2c8a-1)
  (:domain appworld-9bf2c8a-1)
  (:objects
    cory-wilson - person
    corwils-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cart-product-1 cart-product-2 cart-product-3 - product
    qty-of-cart-product-1 qty-of-cart-product-2 - quantity
  )
  (:init
    (username-for amazon corwils-at-gmail-com)
    (password-for amazon amazon-password)
    (in-cart cart-product-1)
    (in-cart cart-product-2)
    (in-cart cart-product-3)
    (is-food-processor cart-product-1)
    (is-food-processor cart-product-2)
    (cart-quantity cart-product-1 qty-of-cart-product-1)
    (cart-quantity cart-product-2 qty-of-cart-product-2)
  )
  (:goal (and
    (in-wish-list cart-product-1)
    (not (in-cart cart-product-1))
    (in-wish-list cart-product-2)
    (not (in-cart cart-product-2))
    (task-completed)
  ))
)
