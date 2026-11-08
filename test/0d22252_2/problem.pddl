(define (problem task-0d22252-2)
  (:domain appworld-0d22252-2)
  (:objects
    william-martinez - person
    william-mart-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    quantity-of-mouse-pad-1 quantity-of-mouse-pad-2 quantity-of-other-product - quantity
    home-address - address
    primary-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (in-wish-list mouse-pad-1)
    (in-wish-list mouse-pad-2)
    (in-wish-list other-product)
    (wish-list-quantity mouse-pad-1 quantity-of-mouse-pad-1)
    (wish-list-quantity mouse-pad-2 quantity-of-mouse-pad-2)
    (wish-list-quantity other-product quantity-of-other-product)
    (is-type mouse-pad-1 mouse-pad)
    (is-type mouse-pad-2 mouse-pad)
  )
  (:goal (and
    (order-placed)
    (in-cart mouse-pad-1)
    (in-cart mouse-pad-2)
    (in-wish-list other-product)
    (not (in-cart other-product))
    (task-completed)
  ))
)
