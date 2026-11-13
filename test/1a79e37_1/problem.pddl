(define (problem task-1a79e37-1)
  (:domain appworld-1a79e37-1)
  (:objects
    katie husband - person
    phone-number-6727300099 kat-simp-at-gmail-com - username
    phone-password gmail-password amazon-password - password
    phone-token gmail-token amazon-token - token
    husband-email - email
    relationship-husband - relationship
    datetime-2023-05-18 - datetime
    husband-email-thread - email-thread
    requested-product-type - product-type
    requested-max-price - price
    sort-key-rating-desc - sort-key
    top-rated-product - product
    quantity-1 - quantity
    flag-true - flag
    husband-work-address - work-address
    husband-name - address-name
    husband-street - street
    husband-city - city
    husband-state - state
    husband-country - country
    husband-zip - zipcode
    husband-work-amazon-address - address
    payment-card-1 - payment-card
    new-order - order
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (username-for phone phone-number-6727300099)
    (username-for gmail kat-simp-at-gmail-com)
    (username-for amazon kat-simp-at-gmail-com)
    (has-relationship husband relationship-husband)
    (email-of husband husband-email)
    (work-address-of husband husband-work-address)
    (address-components husband-work-address husband-name husband-street husband-city husband-state husband-country husband-zip)
    (today datetime-2023-05-18)
    (thread-from husband-email-thread husband)
    (request-in-thread husband-email-thread requested-product-type requested-max-price)
    (sorts-by-rating-desc sort-key-rating-desc)
    (matches-request top-rated-product requested-product-type requested-max-price)
    (quantity-one quantity-1)
    (is-true flag-true)
    (amazon-address-for husband-work-amazon-address husband-work-address)
  )
  (:goal (and
    (order-placed new-order top-rated-product quantity-1 husband-work-amazon-address)
    (address-added husband-work-amazon-address husband-work-address)
    (task-completed)
  ))
)
