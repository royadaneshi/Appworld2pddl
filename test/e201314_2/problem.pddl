(define (problem task-e201314-2)
  (:domain appworld-e201314-2)
  (:objects
    edwin - person
    user-8506051563 user-ed-wilson-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    coworker friend - relationship
    electric-shaver - product-type
    rating-4-0 - rating
    reviews-7 - review-count
    deadline-2023-05-27 - deadline
    shaver - product
    quantity-num-invitees - quantity
    flag-true - flag
    addr-home - address
    card-default - payment-card
  )
  (:init
    (username-for phone user-8506051563)
    (username-for amazon user-ed-wilson-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (invitee-relation coworker)
    (invitee-relation friend)
    (invitee-quantity quantity-num-invitees coworker friend)
    (required-product-type electric-shaver)
    (required-min-rating rating-4-0)
    (required-min-reviews reviews-7)
    (delivery-deadline deadline-2023-05-27)
    (true-flag flag-true)
    (home-address addr-home)
  )
  (:goal (and (gifts-ordered) (task-completed)))
)
