(define (problem task-9ef034e-2)
  (:domain appworld-9ef034e-2)
  (:objects
    jamie ronald - person
    username-8456546003 jamie-solomon-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    query-ronald query-product - query
    ronald-phone-number - phone-number
    ronald-email - email
    requested-product - product
    requested-quantity - quantity
    jamie-home-address - address
    amazon-card - payment-card
    order-1 - order
    amount-order-total - amount
    payment-request-1 - payment-request)
  (:init
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
    (product-query requested-product query-product)
    (requested requested-product requested-quantity)
    (home-address jamie-home-address)
    (order-total order-1 amount-order-total))
  (:goal (and
    (order-placed order-1)
    (request-sent payment-request-1)
    (task-completed)))
)
