(define (problem task-b0934aa-3)
  (:domain appworld-b0934aa-3)
  (:objects
    spencer - person
    spencer-powell-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    hedge-trimmer - product-type
    max-price-60 - price-limit
    min-rating-3-9 - rating-limit
    hedge-trimmer-product - product
    home-address - address
    payment-card-1 - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (target-type hedge-trimmer)
    (target-max-price max-price-60)
    (target-min-rating min-rating-3-9)
    (is-home home-address)
  )
  (:goal (and
    (ordered hedge-trimmer-product home-address)
    (task-completed)
  ))
)
