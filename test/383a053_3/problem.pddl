(define (problem task-383a053-3)
  (:domain appworld-383a053-3)
  (:objects
    anita - person
    anita-burch-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-extension-cord - query
    rating-3-9 rating-4-0 - rating
    extension-cord-product - product
    quantity-3 - quantity
    work-address home-address - address
    payment-card-1 - payment-card)
  (:init
    (password-for amazon amazon-password)
    (product-query extension-cord-product query-extension-cord)
    (min-product-rating rating-3-9)
    (min-seller-rating rating-4-0)
    (required-quantity quantity-3)
    (is-work-address work-address))
  (:goal (and (order-placed extension-cord-product quantity-3 work-address) (task-completed)))
)
