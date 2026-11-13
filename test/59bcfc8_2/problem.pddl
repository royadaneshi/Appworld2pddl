(define (problem task-59bcfc8-2)
  (:domain appworld-59bcfc8-2)
  (:objects
    miranda jennifer - person
    phone-username-4885870260 amazon-username-mir-powe-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-jennifer query-wall-clock - query
    jennifer-phone-number - phone-number
    jennifer-favorite-color - color
    top-rated-wall-clock - product
    jennifer-home-address - address
    jennifer-addr-name - addr-name
    jennifer-street - street
    jennifer-city - city
    jennifer-state - state
    jennifer-country - country
    jennifer-zip-code - zip-code
    amazon-payment-card - payment-card
  )
  (:init
    (credential-of-app phone phone-username-4885870260)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon amazon-username-mir-powe-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for phone phone-username-4885870260)
    (username-for amazon amazon-username-mir-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (query-for-person query-jennifer jennifer)
    (product-query query-wall-clock)
    (address-parts jennifer-home-address jennifer-addr-name jennifer-street jennifer-city jennifer-state jennifer-country jennifer-zip-code)
  )
  (:goal (and
    (ordered top-rated-wall-clock jennifer-home-address)
    (gift-wrapped top-rated-wall-clock)
    (task-completed)
  ))
)
