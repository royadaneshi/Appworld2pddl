(define (problem task-9bf2c8a-2)
  (:domain appworld-9bf2c8a-2)
  (:objects
    andrew - person
    andrew-brow-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    watch-1 watch-2 watch-3 non-watch-item-1 - product)
  (:init
    (password-for amazon amazon-password)
    (is-watch watch-1)
    (is-watch watch-2)
    (is-watch watch-3)
    (in-wish-list watch-1)
    (in-wish-list watch-2)
    (in-wish-list watch-3)
    (in-wish-list non-watch-item-1))
  (:goal (and
    (in-cart watch-1)
    (in-cart watch-2)
    (in-cart watch-3)
    (not (in-wish-list watch-1))
    (not (in-wish-list watch-2))
    (not (in-wish-list watch-3))
    (task-completed)))
)
