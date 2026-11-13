(define (problem task-efc3cea-1)
  (:domain appworld-efc3cea-1)
  (:objects
    joseph-weber - person
    joseph-webe-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-flight - query
    flight-confirmation-thread - email-thread
    backpack - product-type
    backpack-giftable - product
    quantity-4 - quantity
    flag-true - flag
    home-address - address
    default-payment-card - payment-card
  )
  (:init
    (credential-of-app gmail joseph-webe-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app amazon joseph-webe-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-matches query-flight flight-confirmation-thread)
    (flight-confirmation flight-confirmation-thread)
    (product-has-type backpack-giftable backpack)
    (within-weight-budget backpack-giftable)
    (gift-wrappable backpack-giftable)
    (target-quantity quantity-4)
    (is-home-address home-address)
  )
  (:goal (and
    (ordered backpack-giftable quantity-4)
    (ordered-gift-wrapped backpack-giftable quantity-4)
    (shipped-to home-address)
    (task-completed)
  ))
)
