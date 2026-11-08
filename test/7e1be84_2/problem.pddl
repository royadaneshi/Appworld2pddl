(define (problem task-7e1be84-2)
  (:domain appworld-7e1be84-2)
  (:objects
    jennifer-powell connor - person
    jepowell-at-gmail-com username-4288705164 - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-connor query-mixer query-name-of-mixer-cheaper query-name-of-mixer-expensive - query
    connor-phone-number - phone-number
    connor-recommendation-message - text-message
    mixer-cheaper mixer-expensive - product
    stand-mixer - product-type
    qty-1 - quantity
    flag-true - boolean
    amazon-payment-card - payment-card
    home-address - address)
  (:init
    (username-for phone username-4288705164)
    (username-for amazon jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (contact-query connor query-connor)
    (phone-of connor connor-phone-number)
    (message-from connor connor-recommendation-message)
    (message-query connor-recommendation-message query-mixer)
    (recommended-in connor-recommendation-message mixer-cheaper)
    (recommended-in connor-recommendation-message mixer-expensive)
    (product-query mixer-cheaper query-name-of-mixer-cheaper)
    (product-query mixer-expensive query-name-of-mixer-expensive)
    (product-type-of mixer-cheaper stand-mixer)
    (product-type-of mixer-expensive stand-mixer)
    (cheaper-than mixer-cheaper mixer-expensive)
    (quantity-one qty-1)
    (is-true flag-true))
  (:goal (and (ordered mixer-cheaper qty-1) (task-completed)))
)
