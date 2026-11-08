(define (problem task-07bb666-2)
  (:domain appworld-07bb666-2)
  (:objects
    cody-smith - person
    cod-smith-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    qty-wl-1 qty-wl-2 qty-wl-3 qty-wl-4 - quantity
  )
  (:init
    (password-for amazon amazon-password)
    (in-wish-list wl-product-1)
    (in-wish-list wl-product-2)
    (in-wish-list wl-product-3)
    (in-wish-list wl-product-4)
    (wish-list-quantity wl-product-1 qty-wl-1)
    (wish-list-quantity wl-product-2 qty-wl-2)
    (wish-list-quantity wl-product-3 qty-wl-3)
    (wish-list-quantity wl-product-4 qty-wl-4)
    (rating-over-threshold wl-product-1)
    (rating-over-threshold wl-product-2)
    (rating-over-threshold wl-product-3)
  )
  (:goal (and
    (in-cart wl-product-1) (not (in-wish-list wl-product-1))
    (in-cart wl-product-2) (not (in-wish-list wl-product-2))
    (in-cart wl-product-3) (not (in-wish-list wl-product-3))
    (in-wish-list wl-product-4) (not (in-cart wl-product-4))
    (task-completed)
  ))
)
