(define (problem task-0d22252-1)
  (:domain appworld-0d22252-1)
  (:objects
    caitlin-burch - person
    caiburc-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    payment-card-1 - payment-card
    address-1 - address
    wish-qty-1 wish-qty-other - quantity
    wrench-set-1 wrench-set-2 other-wish-list-product-1 other-wish-list-product-2 other-wish-list-product-3 other-wish-list-product-4 other-wish-list-product-5 other-wish-list-product-6 other-wish-list-product-7 other-wish-list-product-8 - product
  )
  (:init
    (password-for amazon amazon-password)
    (is-wrench-set wrench-set-1)
    (is-wrench-set wrench-set-2)
    (wish-listed wrench-set-1 wish-qty-1)
    (wish-listed wrench-set-2 wish-qty-1)
    (wish-listed other-wish-list-product-1 wish-qty-1)
    (wish-listed other-wish-list-product-2 wish-qty-1)
    (wish-listed other-wish-list-product-3 wish-qty-other)
    (wish-listed other-wish-list-product-4 wish-qty-other)
    (wish-listed other-wish-list-product-5 wish-qty-1)
    (wish-listed other-wish-list-product-6 wish-qty-other)
    (wish-listed other-wish-list-product-7 wish-qty-1)
    (wish-listed other-wish-list-product-8 wish-qty-1))
  (:goal (and
    (order-placed)
    (in-cart wrench-set-1 wish-qty-1)
    (in-cart wrench-set-2 wish-qty-1)
    (wish-listed other-wish-list-product-1 wish-qty-1)
    (wish-listed other-wish-list-product-2 wish-qty-1)
    (wish-listed other-wish-list-product-3 wish-qty-other)
    (wish-listed other-wish-list-product-4 wish-qty-other)
    (wish-listed other-wish-list-product-5 wish-qty-1)
    (wish-listed other-wish-list-product-6 wish-qty-other)
    (wish-listed other-wish-list-product-7 wish-qty-1)
    (wish-listed other-wish-list-product-8 wish-qty-1)
    (task-completed)))
)
