(define (problem task-eb5ad85-3)
  (:domain appworld-eb5ad85-3)
  (:objects
    jeffery-simpson - person
    je-simpson-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    order-1 order-2 - order
    spend-0 spend-after-order-1 spend-after-order-2 - amount)
  (:init
    (username-for amazon je-simpson-at-gmail-com)
    (password-for amazon amazon-password)
    (in-period order-1)
    (in-period order-2)
    (running-spend spend-0)
    (adds-to-spend order-1 spend-0 spend-after-order-1)
    (adds-to-spend order-2 spend-after-order-1 spend-after-order-2)
    (final-spend spend-after-order-2))
  (:goal (and (running-spend spend-after-order-2) (task-completed))))
