(define (problem task-6474048-1)
  (:domain appworld-6474048-1)
  (:objects
    jennifer-powell - person
    jepowell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-microwave - query
    rating-4-2 - rating
    microwave-product - product
    supervisor-card - payment-card
    home-address - address
  )
  (:init
    (password-for amazon amazon-password)
    (query-for-product query-microwave microwave-product)
    (rating-threshold rating-4-2)
  )
  (:goal (and
    (purchased microwave-product)
    (task-completed)
  ))
)
