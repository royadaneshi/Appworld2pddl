(define (problem task-6474048-2)
  (:domain appworld-6474048-2)
  (:objects
    tracy-weber - person
    tra-weber-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-coffee-grinder - query
    type-coffee-grinder - product-type
    rating-4-5 - rating
    qty-1 - quantity
    coffee-grinder-product - product
    home-address - address
    primary-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (product-type-of coffee-grinder-product type-coffee-grinder)
  )
  (:goal (and
    (ordered coffee-grinder-product qty-1)
    (task-completed)
  ))
)
