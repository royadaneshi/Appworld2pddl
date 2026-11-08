(define (problem task-1a79e37-3)
  (:domain appworld-1a79e37-3)
  (:objects
    katherine partner - person
    phone-number-7863159797 ka-ball-at-gmail-com - username
    phone-password gmail-password amazon-password - password
    phone-token gmail-token amazon-token - token
    rel-partner - relationship
    partner-email - email
    date-2023-05-18 - date
    partner-thread-today - thread
    requested-product-type - product-type
    requested-max-price - price
    sort-rating-desc - sort-key
    best-product - product
    qty-1 - quantity
    flag-true - flag
    partner-work-address - address
    partner-address-name - addr-name
    partner-street - street
    partner-city - city
    partner-state - state
    partner-country - country
    partner-zip - zipcode
    amazon-card - payment-card
    new-order - order)
  (:init
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (username-for phone phone-number-7863159797)
    (username-for gmail ka-ball-at-gmail-com)
    (username-for amazon ka-ball-at-gmail-com)
    (has-relationship partner rel-partner)
    (contact-email partner partner-email)
    (contact-work-address partner partner-work-address)
    (address-name partner-work-address partner-address-name)
    (address-street partner-work-address partner-street)
    (address-city partner-work-address partner-city)
    (address-state partner-work-address partner-state)
    (address-country partner-work-address partner-country)
    (address-zip partner-work-address partner-zip)
    (today date-2023-05-18)
    (thread-from partner-thread-today partner-email)
    (thread-date partner-thread-today date-2023-05-18)
    (email-requests partner-thread-today requested-product-type requested-max-price partner-work-address)
    (top-rated-product best-product requested-product-type requested-max-price))
  (:goal (and (ordered new-order best-product partner-work-address)
              (task-completed))))
