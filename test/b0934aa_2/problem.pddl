(define (problem task-b0934aa-2)
  (:domain appworld-b0934aa-2)
  (:objects
    grant-martinez - person
    gra-martinez-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-external-hard-drive - query
    ptype-external-hard-drive - product-type
    price-50 - price
    rating-3-8 - rating
    quantity-1 - quantity
    flag-true - flag
    external-hard-drive - product
    work-address - address
    amazon-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (search-criteria query-external-hard-drive ptype-external-hard-drive price-50 rating-3-8)
    (quantity-one quantity-1)
    (clear-cart-flag flag-true)
    (target-delivery work-address)
  )
  (:goal (and
    (ordered external-hard-drive work-address)
    (task-completed)
  ))
)
