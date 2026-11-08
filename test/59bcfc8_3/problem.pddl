(define (problem task-59bcfc8-3)
  (:domain appworld-59bcfc8-3)
  (:objects
    sierra valerie - person
    phone-7295077363 siwhit-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-valerie - query
    valerie-phone-number - phone-number
    valerie-favorite-color - color
    product-type-sweater - product-type
    sort-by-rating-desc - sort-key
    sweater-best - product
    valerie-home - address
    valerie-addr-name - addr-name
    valerie-street - street
    valerie-city - city
    valerie-state - state
    valerie-country - country
    valerie-zip - zipcode
    sierra-card - payment-card
    quantity-1 - quantity
    order-1 - order)
  (:init
    (username-for phone phone-7295077363)
    (username-for amazon siwhit-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (contact-query valerie query-valerie)
    (phone-of valerie valerie-phone-number)
    (address-of valerie valerie-home)
    (address-parts valerie-home valerie-addr-name valerie-street valerie-city valerie-state valerie-country valerie-zip)
    (favorite-color-of valerie valerie-favorite-color)
    (product-type-of sweater-best product-type-sweater)
    (product-color sweater-best valerie-favorite-color)
    (highest-rated sweater-best)
    (sorts-by-rating-desc sort-by-rating-desc))
  (:goal (and (ordered order-1 sweater-best valerie-home) (ordered-with-gift-wrap order-1) (task-completed))))
