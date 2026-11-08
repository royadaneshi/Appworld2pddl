(define (problem task-6474048-3)
  (:domain appworld-6474048-3)
  (:objects
    anthony - person
    an-harrison-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-cutting-board - query
    cutting-board - product-type
    rating-4-1 - rating
    cutting-board-product - product
    kitchen-drawer-12-0-by-9-5 - drawer
    quantity-1 - quantity
    home-address - address
    payment-card-1 - payment-card)
  (:init
    (username-for amazon an-harrison-at-gmail-com)
    (password-for amazon amazon-password)
    (query-for query-cutting-board cutting-board)
    (required-product-type cutting-board)
    (required-min-seller-rating rating-4-1)
    (target-drawer kitchen-drawer-12-0-by-9-5)
    (single-unit quantity-1))
  (:goal (and (order-placed) (task-completed))))
