(define (problem task-9ef034e-2)
  (:domain appworld-9ef034e-2)
  (:objects
    jamie ronald - person
    username-8456546003 jamie-solomon-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    query-ronald query-product-1 query-product-2 query-product-3 - query
    ronald-phone-number - phone-number
    ronald-email - email
    requested-product-1 requested-product-2 requested-product-3 - product
    requested-quantity-1 requested-quantity-2 requested-quantity-3 - quantity
    jamie-home-address - address
    amazon-card - payment-card
    order-1 - order
    amount-order-total - amount
    payment-request-1 - payment-request
  )
  (:init
    (credential-of-app phone username-8456546003)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app amazon jamie-solomon-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app venmo jamie-solomon-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-8456546003)
    (username-for amazon jamie-solomon-at-gmail-com)
    (username-for venmo jamie-solomon-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (message-sender ronald)
    (contact-query ronald query-ronald)
    (contact-phone ronald ronald-phone-number)
    (contact-email ronald ronald-email)
    (product-query requested-product-1 query-product-1)
    (product-query requested-product-2 query-product-2)
    (product-query requested-product-3 query-product-3)
    (requested requested-product-1 requested-quantity-1)
    (requested requested-product-2 requested-quantity-2)
    (requested requested-product-3 requested-quantity-3)
    (home-address jamie-home-address)
    (order-total order-1 amount-order-total))
  (:goal (and
    (order-placed order-1)
    (request-sent payment-request-1)
    (task-completed)
    (ordered order-1 requested-product-1 requested-quantity-1)
    (ordered order-1 requested-product-2 requested-quantity-2)
    (ordered order-1 requested-product-3 requested-quantity-3)))
)
