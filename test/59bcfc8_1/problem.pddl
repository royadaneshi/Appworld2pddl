(define (problem task-59bcfc8-1)
  (:domain appworld-59bcfc8-1)
  (:objects
    jennifer jeremy - person
    phone-username-4288705164 amazon-username-jepowell-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-jeremy query-t-shirt - query
    jeremy-phone-number - phone-number
    jeremy-favorite-color - color
    highest-rated-t-shirt - product
    type-t-shirt - product-type
    qty-1 - quantity
    jeremy-home-address - address
    jeremy-full-name - address-name
    jeremy-street - street
    jeremy-city - city
    jeremy-state - state
    jeremy-country - country
    jeremy-zipcode - zipcode
    supervisor-payment-card - payment-card
    sort-rating-desc - sort-key)
  (:init
    (credential-of-app phone phone-username-4288705164)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon amazon-username-jepowell-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (username-for phone phone-username-4288705164)
    (username-for amazon amazon-username-jepowell-at-gmail-com)
    (recipient jeremy)
    (contact-query jeremy query-jeremy)
    (phone-of jeremy jeremy-phone-number)
    (home-address-of jeremy jeremy-home-address)
    (favorite-color-of jeremy jeremy-favorite-color)
    (address-parts jeremy-home-address jeremy-full-name jeremy-street jeremy-city jeremy-state jeremy-country jeremy-zipcode)
    (wanted-type type-t-shirt)
    (search-query-for query-t-shirt type-t-shirt)
    (rating-sort sort-rating-desc)
    (highest-rated highest-rated-t-shirt type-t-shirt jeremy-favorite-color))
  (:goal (and
    (order-placed highest-rated-t-shirt jeremy-home-address)
    (gift-wrapped highest-rated-t-shirt qty-1)
    (task-completed)))
)
