(define (problem task-690d51b-1)
  (:domain appworld-690d51b-1)
  (:objects
    bradley - person
    bradley-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-kitchen-timer - query
    amount-10 - amount
    quantity-1 - quantity
    kitchen-timer-product - product
    address-home - address
    payment-card-main - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (product-matches kitchen-timer-product query-kitchen-timer)
    (price-within kitchen-timer-product amount-10)
    (home-address address-home)
  )
  (:goal (and
    (ordered kitchen-timer-product address-home quantity-1)
    (task-completed)
  ))
)
