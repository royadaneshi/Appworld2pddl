(define (problem task-07bb666-1)
  (:domain appworld-07bb666-1)
  (:objects
    katherine - person
    ka-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    product-a product-b - product)
  (:init
    (password-for amazon amazon-password)
    (in-cart product-a)
    (in-cart product-b)
    (rating-under-threshold product-a))
  (:goal (and
    (rating-known product-a)
    (rating-known product-b)
    (in-wish-list product-a)
    (not (in-cart product-a))
    (in-cart product-b)
    (task-completed))))
