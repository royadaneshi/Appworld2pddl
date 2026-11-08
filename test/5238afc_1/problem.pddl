(define (problem task-5238afc-1)
  (:domain appworld-5238afc-1)
  (:objects
    jennifer-powell - person
    jepowell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    bench-product-1 bench-product-2 other-product-1 other-product-2 other-product-3 - product
    amazon-address-1 - address
    amazon-payment-card-1 - payment-card
    bench-order - order
    one two three - count)
  (:init
    (password-for amazon amazon-password)
    (in-cart bench-product-1)
    (in-cart bench-product-2)
    (in-cart other-product-1)
    (in-cart other-product-2)
    (in-cart other-product-3)
    (is-weightlifting-bench bench-product-1)
    (is-weightlifting-bench bench-product-2)
    (unwanted-in-cart three)
    (count-pred zero one)
    (count-pred one two)
    (count-pred two three))
  (:goal (and (order-placed bench-order) (task-completed))))
