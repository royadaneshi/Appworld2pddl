(define (problem task-1a79e37-2)
  (:domain appworld-1a79e37-2)
  (:objects
    michael-burch wife - person
    mi-burch-at-gmail-com phone-8095050664 - username
    phone-password gmail-password amazon-password - password
    phone-token gmail-token amazon-token - token
    wife-email - email
    relationship-wife - relationship
    date-2023-05-18 - datetime
    wife-thread-today - thread
    requested-product-type - product-type
    requested-max-price - price
    sort-by-rating-desc - sort-key
    requested-product - product
    quantity-1 - quantity
    flag-true - flag
    wife-work-address - address
    wife-address-name - address-name
    wife-work-street - street
    wife-work-city - city
    wife-work-state - state
    wife-work-country - country
    wife-work-zip - zip
    supervisor-payment-card - payment-card
  )
  (:init
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (username-for phone phone-8095050664)
    (username-for gmail mi-burch-at-gmail-com)
    (username-for amazon mi-burch-at-gmail-com)
    (token-for phone phone-token)
    (token-for gmail gmail-token)
    (token-for amazon amazon-token)
    (relation-of wife relationship-wife)
    (email-of wife wife-email)
    (work-address-of wife wife-work-address)
    (thread-from wife-thread-today wife-email)
    (thread-requests wife-thread-today requested-product-type requested-max-price)
    (best-match requested-product requested-product-type requested-max-price)
    (address-fields wife-work-address wife-address-name wife-work-street wife-work-city wife-work-state wife-work-country wife-work-zip)
  )
  (:goal (and
    (order-placed requested-product wife-work-address)
    (task-completed)
  ))
)
