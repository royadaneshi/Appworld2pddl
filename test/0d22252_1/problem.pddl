(define (problem task-0d22252-1)
  (:domain appworld-0d22252-1)
  (:objects
    caitlin-burch - person
    caiburc-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    wrench-set-1 wrench-set-2 other-wish-list-product - product
    wish-qty-1 wish-qty-2 wish-qty-other - quantity
    payment-card-1 - payment-card
    address-1 - address
  )
  (:init
    (password-for amazon amazon-password)
    (is-wrench-set wrench-set-1)
    (is-wrench-set wrench-set-2)
    (wish-listed wrench-set-1 wish-qty-1)
    (wish-listed wrench-set-2 wish-qty-2)
    (wish-listed other-wish-list-product wish-qty-other)
  )
  (:goal (and
    (order-placed)
    (in-cart wrench-set-1 wish-qty-1)
    (in-cart wrench-set-2 wish-qty-2)
    (wish-listed other-wish-list-product wish-qty-other)
    (task-completed)
  ))
)
