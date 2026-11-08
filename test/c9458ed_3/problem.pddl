(define (problem task-c9458ed-3)
  (:domain appworld-c9458ed-3)
  (:objects
    erica-wilson - person
    phone-user-4675246489 amazon-user-eri-powe-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    query-proform-pro-2000-treadmill - query
    proform-pro-2000-treadmill - product
    best-promo-code - promo-code
    clear-cart-first-true - flag
    amazon-payment-card - payment-card
    amazon-address - address)
  (:init
    (username-for phone phone-user-4675246489)
    (username-for amazon amazon-user-eri-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (product-query query-proform-pro-2000-treadmill proform-pro-2000-treadmill))
  (:goal (and
    (order-placed proform-pro-2000-treadmill best-promo-code)
    (task-completed)))
)
