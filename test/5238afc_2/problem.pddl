(define (problem task-5238afc-2)
  (:domain appworld-5238afc-2)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    home-address - address
    payment-card-1 - payment-card
    other-product-1 other-product-2 other-product-3 other-product-4 other-product-5 other-product-6 other-product-7 other-product-8 other-product-9 other-product-10 other-product-11 other-product-12 other-product-13 beach-ball-1 beach-ball-2 beach-ball-3 beach-ball-4 - product
    n1-1 n1-2 n1-3 n1-4 n1-5 n1-6 n1-7 n1-8 n1-9 n1-10 n1-11 n1-12 n3 - count
  )
  (:init
    (password-for amazon amazon-password)
    (in-cart other-product-1)
    (in-cart other-product-2)
    (in-cart other-product-3)
    (in-cart other-product-4)
    (in-cart other-product-5)
    (in-cart other-product-6)
    (in-cart other-product-7)
    (in-cart other-product-8)
    (in-cart other-product-9)
    (in-cart other-product-10)
    (in-cart other-product-11)
    (in-cart other-product-12)
    (in-cart other-product-13)
    (in-cart beach-ball-1)
    (in-cart beach-ball-2)
    (in-cart beach-ball-3)
    (in-cart beach-ball-4)
    (is-beach-ball beach-ball-1)
    (is-beach-ball beach-ball-2)
    (is-beach-ball beach-ball-3)
    (is-beach-ball beach-ball-4)
    (succ n0 n1-1)
    (succ n1-1 n1-2)
    (succ n1-2 n1-3)
    (succ n1-3 n1-4)
    (succ n1-4 n1-5)
    (succ n1-5 n1-6)
    (succ n1-6 n1-7)
    (succ n1-7 n1-8)
    (succ n1-8 n1-9)
    (succ n1-9 n1-10)
    (succ n1-10 n1-11)
    (succ n1-11 n1-12)
    (succ n1-12 n3)
    (others-in-cart n3))
  (:goal (and (order-placed) (task-completed)))
)
