(define (problem task-dbc0276-1)
  (:domain appworld-dbc0276-1)
  (:objects
    katherine husband - person
    ka-ball-at-gmail-com phone-7863159797 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    wishlist-product - product
    rel-husband - relationship
    husband-phone-number - phone-number
    wish-list-message - message)
  (:init
    (username-for amazon ka-ball-at-gmail-com)
    (username-for phone phone-7863159797)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (has-relationship husband rel-husband)
    (message-itemizes wish-list-message wishlist-product))
  (:goal (and (text-sent husband wish-list-message) (task-completed))))
