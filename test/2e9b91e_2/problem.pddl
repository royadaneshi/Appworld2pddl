(define (problem task-2e9b91e-2)
  (:domain appworld-2e9b91e-2)
  (:objects
    jordan troy - person
    jo-harr-at-gmail-com phone-2254213734 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    query-troy - query
    troy-email - email
    cart-cost-amount - amount)
  (:init
    (username-for amazon jo-harr-at-gmail-com)
    (username-for venmo jo-harr-at-gmail-com)
    (username-for phone phone-2254213734)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for amazon amazon-token)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (roommate troy)
    (query-for query-troy troy)
    (email-of troy troy-email)
    (cart-cost cart-cost-amount))
  (:goal (and
    (payment-request-sent troy cart-cost-amount)
    (task-completed)))
)
