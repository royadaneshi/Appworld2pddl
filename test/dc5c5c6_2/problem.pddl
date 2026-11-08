(define (problem task-dc5c5c6-2)
  (:domain appworld-dc5c5c6-2)
  (:objects
    matthew-blackburn brother-1 brother-2 - person
    matthew-blac-at-gmail-com phone-4886643554 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    brother - relationship
    watch - product-type
    sort-rating-desc - sort-key
    top-rated-watch - product
    supervisor-card - payment-card
    addr-brother-1 addr-brother-2 - address
    name-brother-1 name-brother-2 - recipient-name
    street-brother-1 street-brother-2 - street
    city-brother-1 city-brother-2 - city
    state-brother-1 state-brother-2 - state
    country-brother-1 country-brother-2 - country
    zip-brother-1 zip-brother-2 - zip-code
    quantity-1 - quantity
    flag-true - flag)
  (:init
    (username-for amazon matthew-blac-at-gmail-com)
    (username-for phone phone-4886643554)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (sibling-relation brother)
    (is-brother brother-1)
    (is-brother brother-2)
    (home-address brother-1 addr-brother-1)
    (home-address brother-2 addr-brother-2)
    (address-recipient addr-brother-1 name-brother-1)
    (address-street addr-brother-1 street-brother-1)
    (address-city addr-brother-1 city-brother-1)
    (address-state addr-brother-1 state-brother-1)
    (address-country addr-brother-1 country-brother-1)
    (address-zip addr-brother-1 zip-brother-1)
    (address-recipient addr-brother-2 name-brother-2)
    (address-street addr-brother-2 street-brother-2)
    (address-city addr-brother-2 city-brother-2)
    (address-state addr-brother-2 state-brother-2)
    (address-country addr-brother-2 country-brother-2)
    (address-zip addr-brother-2 zip-brother-2)
    (top-rated-available top-rated-watch watch)
    (sort-by-rating sort-rating-desc)
    (card-on-file supervisor-card)
    (quantity-one quantity-1)
    (true-flag flag-true))
  (:goal (and
    (gift-ordered brother-1 top-rated-watch addr-brother-1)
    (gift-ordered brother-2 top-rated-watch addr-brother-2)
    (task-completed)))
)
