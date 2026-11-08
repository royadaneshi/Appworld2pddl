(define (problem task-66b7899-2)
  (:domain appworld-66b7899-2)
  (:objects
    nicholas anita - person
    nicholas-weber-at-gmail-com phone-9503658964 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    query-anita - query
    anita-email - email
    order-delivered-today - order
    order-cost - amount)
  (:init
    (username-for amazon nicholas-weber-at-gmail-com)
    (username-for venmo nicholas-weber-at-gmail-com)
    (username-for phone phone-9503658964)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (delivery-today order-delivered-today)
    (order-for order-delivered-today anita)
    (contact-query anita query-anita))
  (:goal (and (payment-requested anita order-cost) (task-completed)))
)
