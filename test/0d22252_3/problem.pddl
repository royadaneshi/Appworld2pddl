(define (problem task-0d22252-3)
  (:domain appworld-0d22252-3)
  (:objects
    nancy-ritter - person
    nan-ritt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    handheld-vacuum-cleaner other-product-type - product-type
    vacuum-product-1 vacuum-product-2 other-wish-list-product - product
    quantity-of-vacuum-product-1 quantity-of-vacuum-product-2 quantity-of-other-wish-list-product - quantity
    default-address - address
    default-payment-card - payment-card)
  (:init
    (username-for amazon nan-ritt-at-gmail-com)
    (password-for amazon amazon-password)
    (target-product-type handheld-vacuum-cleaner)
    (in-wish-list vacuum-product-1)
    (in-wish-list vacuum-product-2)
    (in-wish-list other-wish-list-product)
    (wish-list-quantity vacuum-product-1 quantity-of-vacuum-product-1)
    (wish-list-quantity vacuum-product-2 quantity-of-vacuum-product-2)
    (wish-list-quantity other-wish-list-product quantity-of-other-wish-list-product)
    (is-of-type vacuum-product-1 handheld-vacuum-cleaner)
    (is-of-type vacuum-product-2 handheld-vacuum-cleaner)
    (is-of-type other-wish-list-product other-product-type))
  (:goal (and
    (order-placed)
    (in-cart vacuum-product-1)
    (in-cart vacuum-product-2)
    (in-wish-list other-wish-list-product)
    (not (in-cart other-wish-list-product))
    (task-completed))))
