(define (problem task-7e1be84-3)
  (:domain appworld-7e1be84-3)
  (:objects
    brandon mason - person
    user-3798762980 brandon-webe-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-mason - query
    mason-phone-number - phone-number
    mason-backpack-message - text-message
    recommended-backpack-cheaper recommended-backpack-expensive - product
    brandon-payment-card - payment-card
    brandon-address - address
    backpack-order - order)
  (:init
    (credential-of-app phone user-3798762980)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon brandon-webe-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for phone user-3798762980)
    (username-for amazon brandon-webe-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (matches-query query-mason mason)
    (phone-number-of mason mason-phone-number)
    (message-from mason-backpack-message mason-phone-number)
    (mentions mason-backpack-message recommended-backpack-cheaper)
    (mentions mason-backpack-message recommended-backpack-expensive)
    (cheaper-than recommended-backpack-cheaper recommended-backpack-expensive))
  (:goal (and
    (ordered recommended-backpack-cheaper backpack-order)
    (task-completed))))
