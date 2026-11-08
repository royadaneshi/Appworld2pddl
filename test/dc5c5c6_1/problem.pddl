(define (problem task-dc5c5c6-1)
  (:domain appworld-dc5c5c6-1)
  (:objects
    carl-brown sibling-1 sibling-2 - person
    carbrown-at-gmail-com phone-7934818191 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    sibling - relationship
    gaming-console-controller - product-type
    sort-rating-desc - sort-key
    top-rated-controller - product
    amazon-card-1 - payment-card
    home-address-sibling-1 home-address-sibling-2 - address
    name-sibling-1 name-sibling-2 - contact-name
    street-sibling-1 street-sibling-2 - street
    city-sibling-1 city-sibling-2 - city
    state-sibling-1 state-sibling-2 - state
    country-sibling-1 country-sibling-2 - country
    zip-sibling-1 zip-sibling-2 - zip-code
    qty-1 - quantity
    flag-true - flag)
  (:init
    (username-for amazon carbrown-at-gmail-com)
    (username-for phone phone-7934818191)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (token-of amazon amazon-token)
    (token-of phone phone-token)
    (sibling-relationship sibling)
    (is-sibling sibling-1)
    (is-sibling sibling-2)
    (home-address-of sibling-1 home-address-sibling-1)
    (home-address-of sibling-2 home-address-sibling-2)
    (addr-name home-address-sibling-1 name-sibling-1)
    (addr-street home-address-sibling-1 street-sibling-1)
    (addr-city home-address-sibling-1 city-sibling-1)
    (addr-state home-address-sibling-1 state-sibling-1)
    (addr-country home-address-sibling-1 country-sibling-1)
    (addr-zip home-address-sibling-1 zip-sibling-1)
    (addr-name home-address-sibling-2 name-sibling-2)
    (addr-street home-address-sibling-2 street-sibling-2)
    (addr-city home-address-sibling-2 city-sibling-2)
    (addr-state home-address-sibling-2 state-sibling-2)
    (addr-country home-address-sibling-2 country-sibling-2)
    (addr-zip home-address-sibling-2 zip-sibling-2)
    (product-of-type top-rated-controller gaming-console-controller)
    (top-rated-available top-rated-controller))
  (:goal (and
    (gift-ordered sibling-1 top-rated-controller)
    (gift-ordered sibling-2 top-rated-controller)
    (task-completed))))
