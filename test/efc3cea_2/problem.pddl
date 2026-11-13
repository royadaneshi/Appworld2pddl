(define (problem task-efc3cea-2)
  (:domain appworld-efc3cea-2)
  (:objects
    tracy-weber - person
    tra-weber-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-flight query-picture-frame - query
    flight-confirmation-thread - email-thread
    giftable-picture-frame - product
    quantity-5 - quantity
    flag-true - flag
    home-address - address
    tracy-payment-card - payment-card)
  (:init
    (credential-of-app gmail tra-weber-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app amazon tra-weber-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for gmail tra-weber-at-gmail-com)
    (username-for amazon tra-weber-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-query flight-confirmation-thread query-flight)
    (flight-confirmation flight-confirmation-thread)
    (product-query giftable-picture-frame query-picture-frame)
    (is-home-address home-address))
  (:goal (and
    (order-placed giftable-picture-frame quantity-5 home-address)
    (gift-wrapped giftable-picture-frame quantity-5)
    (task-completed)))
)
