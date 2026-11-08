(define (problem task-245cb43-1)
  (:domain appworld-245cb43-1)
  (:objects
    jared-calhoun - person
    jar-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    dish-rack-fitting dish-rack-too-large - product
    card-1 - card
    address-1 - address
    flag-true - flag
  )
  (:init
    (password-for amazon amazon-password)
    (in-wish-list dish-rack-fitting)
    (in-wish-list dish-rack-too-large)
    (dish-rack dish-rack-fitting)
    (dish-rack dish-rack-too-large)
    (fits-countertop dish-rack-fitting)
    (clear-first flag-true)
    (supervisor-card card-1)
    (supervisor-address address-1)
  )
  (:goal (and (fitting-dish-rack-ordered) (task-completed)))
)
