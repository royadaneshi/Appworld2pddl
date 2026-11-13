(define (problem task-7e1be84-1)
  (:domain appworld-7e1be84-1)
  (:objects
    jessica david - person
    username-3808719492 username-jes-mill-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-david query-food-scale - query
    david-phone-number - phone-number
    david-food-scale-message - text-message
    recommended-cheaper-food-scale recommended-expensive-food-scale - product
    quantity-1 - quantity
    clear-cart-true - flag
    home-address - address
    payment-card-1 - payment-card
    new-order - order
  )
  (:init
    (credential-of-app phone username-3808719492)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon username-jes-mill-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for phone username-3808719492)
    (username-for amazon username-jes-mill-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (contact-query david query-david)
    (contact-number david david-phone-number)
    (message-from david-food-scale-message david)
    (message-query david-food-scale-message query-food-scale)
    (recommends david-food-scale-message recommended-cheaper-food-scale)
    (recommends david-food-scale-message recommended-expensive-food-scale)
    (cheaper-than recommended-cheaper-food-scale recommended-expensive-food-scale)
  )
  (:goal (and
    (order-placed new-order recommended-cheaper-food-scale)
    (task-completed)
  ))
)
