(define (problem task-0d22252-3)
  (:domain appworld-0d22252-3)
  (:objects
    nancy-ritter - person
    nan-ritt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    handheld-vacuum-cleaner other-product-type - product-type
    default-address - address
    default-payment-card - payment-card
    quantity-of-vacuum-product-1 quantity-of-vacuum-product-2 - quantity
    vacuum-product-1 vacuum-product-2 vacuum-product-3 vacuum-product-4 vacuum-product-5 vacuum-product-6 vacuum-product-7 vacuum-product-8 - product
  )
  (:init
    (username-for amazon nan-ritt-at-gmail-com)
    (password-for amazon amazon-password)
    (target-product-type handheld-vacuum-cleaner)
    (in-wish-list vacuum-product-1)
    (in-wish-list vacuum-product-2)
    (in-wish-list vacuum-product-3)
    (in-wish-list vacuum-product-4)
    (in-wish-list vacuum-product-5)
    (in-wish-list vacuum-product-6)
    (in-wish-list vacuum-product-7)
    (in-wish-list vacuum-product-8)
    (wish-list-quantity vacuum-product-1 quantity-of-vacuum-product-2)
    (wish-list-quantity vacuum-product-2 quantity-of-vacuum-product-1)
    (wish-list-quantity vacuum-product-3 quantity-of-vacuum-product-2)
    (wish-list-quantity vacuum-product-4 quantity-of-vacuum-product-2)
    (wish-list-quantity vacuum-product-5 quantity-of-vacuum-product-1)
    (wish-list-quantity vacuum-product-6 quantity-of-vacuum-product-2)
    (wish-list-quantity vacuum-product-7 quantity-of-vacuum-product-2)
    (wish-list-quantity vacuum-product-8 quantity-of-vacuum-product-1)
    (is-of-type vacuum-product-6 handheld-vacuum-cleaner)
    (is-of-type vacuum-product-7 handheld-vacuum-cleaner)
    (is-of-type vacuum-product-8 handheld-vacuum-cleaner)
    (is-of-type vacuum-product-1 other-product-type)
    (is-of-type vacuum-product-2 other-product-type)
    (is-of-type vacuum-product-3 other-product-type)
    (is-of-type vacuum-product-4 other-product-type)
    (is-of-type vacuum-product-5 other-product-type))
  (:goal (and
    (order-placed)
    (in-cart vacuum-product-6)
    (in-cart vacuum-product-7)
    (in-cart vacuum-product-8)
    (in-wish-list vacuum-product-1)
    (not (in-cart vacuum-product-1))
    (in-wish-list vacuum-product-2)
    (not (in-cart vacuum-product-2))
    (in-wish-list vacuum-product-3)
    (not (in-cart vacuum-product-3))
    (in-wish-list vacuum-product-4)
    (not (in-cart vacuum-product-4))
    (in-wish-list vacuum-product-5)
    (not (in-cart vacuum-product-5))
    (task-completed))))
