(define (problem task-66b7899-3)
  (:domain appworld-66b7899-3)
  (:objects
    norman edwin - person
    normansmit-at-gmail-com phone-5708520672 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    order-delivered-today - order
    amount-order-total - amount
    edwin-email - email
    query-edwin - query)
  (:init
    (username-for amazon normansmit-at-gmail-com)
    (username-for phone phone-5708520672)
    (username-for venmo normansmit-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (delivery-today order-delivered-today)
    (order-for order-delivered-today edwin)
    (contact-query edwin query-edwin))
  (:goal (and (payment-request-created edwin amount-order-total) (task-completed)))
)
