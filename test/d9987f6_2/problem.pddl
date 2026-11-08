(define (problem task-d9987f6-2)
  (:domain appworld-d9987f6-2)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-gaming-console-controller - query
    rating-3-8 - rating
    gaming-console-controller - product
    quantity-1 - quantity
    work-address - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (search-query query-gaming-console-controller)
    (min-rating rating-3-8)
    (quantity-one quantity-1)
    (is-work-address work-address)
  )
  (:goal (and
    (ordered gaming-console-controller work-address)
    (task-completed)
  ))
)
