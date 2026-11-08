(define (problem task-5238afc-2)
  (:domain appworld-5238afc-2)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    beach-ball-1 beach-ball-2 - product
    other-product-1 other-product-2 other-product-3 - product
    n1 n2 n3 - count
    home-address - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (in-cart beach-ball-1)
    (in-cart beach-ball-2)
    (in-cart other-product-1)
    (in-cart other-product-2)
    (in-cart other-product-3)
    (is-beach-ball beach-ball-1)
    (is-beach-ball beach-ball-2)
    (others-in-cart n3)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
  )
  (:goal (and (order-placed) (task-completed)))
)
