(define (problem task-e201314-3)
  (:domain appworld-e201314-3)
  (:objects
    martin - person
    phone-username-3539110281 amazon-username-mar-blac-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-fitness-tracker - query
    rating-4-1 - rating
    fitness-tracker - product
    quantity-num-invitees - quantity
    flag-true - flag
    home-address - address
    supervisor-payment-card - payment-card)
  (:init
    (username-for phone phone-username-3539110281)
    (username-for amazon amazon-username-mar-blac-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (product-query fitness-tracker query-fitness-tracker)
    (min-rating rating-4-1)
    (invitee-count quantity-num-invitees)
    (is-home-address home-address))
  (:goal (and (ordered fitness-tracker quantity-num-invitees home-address) (task-completed))))
