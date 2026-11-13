(define (problem task-5238afc-1)
  (:domain appworld-5238afc-1)
  (:objects
    jennifer-powell - person
    jepowell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    amazon-address-1 - address
    amazon-payment-card-1 - payment-card
    bench-order - order
    other-product-1 other-product-2 other-product-3 other-product-4 bench-product-1 bench-product-2 bench-product-3 bench-product-4 other-product-5 other-product-6 other-product-7 other-product-8 other-product-9 - product
    one-1 one-2 one-3 one-4 one-5 one-6 one-7 one-8 three - count
  )
  (:init
    (password-for amazon amazon-password)
    (in-cart other-product-1)
    (in-cart other-product-2)
    (in-cart other-product-3)
    (in-cart other-product-4)
    (in-cart bench-product-1)
    (in-cart bench-product-2)
    (in-cart bench-product-3)
    (in-cart bench-product-4)
    (in-cart other-product-5)
    (in-cart other-product-6)
    (in-cart other-product-7)
    (in-cart other-product-8)
    (in-cart other-product-9)
    (is-weightlifting-bench bench-product-1)
    (is-weightlifting-bench bench-product-2)
    (is-weightlifting-bench bench-product-3)
    (is-weightlifting-bench bench-product-4)
    (count-pred zero one-1)
    (count-pred one-1 one-2)
    (count-pred one-2 one-3)
    (count-pred one-3 one-4)
    (count-pred one-4 one-5)
    (count-pred one-5 one-6)
    (count-pred one-6 one-7)
    (count-pred one-7 one-8)
    (count-pred one-8 three)
    (unwanted-in-cart three))
  (:goal (and (order-placed bench-order) (task-completed))))
