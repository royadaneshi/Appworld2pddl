(define (problem task-b6d1f70-3)
  (:domain appworld-b6d1f70-3)
  (:objects
    lindsey mother - person
    lindseysimpson-at-gmail-com phone-3567801924 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    relationship-mother - relationship
    product-type-headphones - product-type
    rating-4-5 - rating
    quantity-1 - quantity
    flag-true - flag
    headphones-product - product
    home-address mother-home-address - address
    mother-address-name - address-name
    mother-street - street
    mother-city - city
    mother-state - state
    mother-country - country
    mother-zip - zip-code
    payment-card-1 - payment-card
  )
  (:init
    (username-for amazon lindseysimpson-at-gmail-com)
    (username-for phone phone-3567801924)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (has-relationship mother relationship-mother)
    (home-address-of lindsey home-address)
    (home-address-of mother mother-home-address)
    (address-fields mother-home-address mother-address-name mother-street mother-city mother-state mother-country mother-zip)
    (listed-in-amazon home-address)
    (product-of-type headphones-product product-type-headphones)
    (wrap-target wrapped mother-home-address)
    (wrap-target unwrapped home-address)
  )
  (:goal (and
    (order-placed wrapped)
    (order-placed unwrapped)
    (task-completed)
  ))
)
