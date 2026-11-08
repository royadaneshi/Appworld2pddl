(define (problem task-d9987f6-3)
  (:domain appworld-d9987f6-3)
  (:objects
    mason-smith - person
    masmith-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-blender - query
    blender - product-type
    rating-4-9 - rating
    blender-rated-over-4-9 - product
    quantity-1 - quantity
    home-address - address
    amazon-payment-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (query-for query-blender blender)
    (product-type-of blender-rated-over-4-9 blender)
    (rating-over blender-rated-over-4-9 rating-4-9)
  )
  (:goal (and
    (order-placed blender-rated-over-4-9 home-address)
    (task-completed)
  ))
)
