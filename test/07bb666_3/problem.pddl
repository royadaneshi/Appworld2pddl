(define (problem task-07bb666-3)
  (:domain appworld-07bb666-3)
  (:objects
    hunter - person
    hun-weaver-at-gmail-com - username
    amazon-password - password
    amazon-token - token)
  (:init
    (password-for amazon amazon-password)
    (in-cart product-1)
    (in-cart product-2)
    (in-cart product-3)
    (in-cart product-4)
    (in-cart product-5)
    (rating-over-4-3 product-1)
    (rating-over-4-3 product-2)
    (rating-over-4-3 product-3))
  (:goal (and
    (in-wish-list product-1) (not (in-cart product-1))
    (in-wish-list product-2) (not (in-cart product-2))
    (in-wish-list product-3) (not (in-cart product-3))
    (in-cart product-4)
    (in-cart product-5)
    (task-completed)))
)
