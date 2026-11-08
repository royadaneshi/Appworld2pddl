(define (problem task-b3bdcc1-3)
  (:domain appworld-b3bdcc1-3)
  (:objects
    adam-blackburn - person
    ad-blackburn-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    portable-air-conditioner - product-type
    top-rated-seller - seller
    pac-from-top-rated-seller - product
    home-address - address
    chase-card - payment-card
    quantity-1 - quantity
  )
  (:init
    (password-for amazon amazon-password)
    (of-type pac-from-top-rated-seller portable-air-conditioner)
    (sold-by pac-from-top-rated-seller top-rated-seller)
    (highest-rated-seller-for top-rated-seller portable-air-conditioner)
  )
  (:goal (and
    (ordered pac-from-top-rated-seller quantity-1 chase-card home-address)
    (task-completed)
  ))
)
