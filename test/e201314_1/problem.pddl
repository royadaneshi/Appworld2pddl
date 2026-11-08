(define (problem task-e201314-1)
  (:domain appworld-e201314-1)
  (:objects
    troy-solomon - person
    username-7273731063 - username
    username-tr-solo-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    product-type-backpack - product-type
    rating-4-5 - rating
    backpack-product - product
    qty-invitees - quantity
    flag-true - flag
    home-address - address
    payment-card-1 - payment-card)
  (:init
    (username-for phone username-7273731063)
    (username-for amazon username-tr-solo-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (target-product-type product-type-backpack)
    (required-min-rating rating-4-5)
    (invitee-count qty-invitees)
    (true-flag flag-true)
    (is-home-address home-address))
  (:goal (and
    (ordered backpack-product qty-invitees home-address)
    (task-completed))))
