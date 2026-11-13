(define (problem task-2e9b91e-3)
  (:domain appworld-2e9b91e-3)
  (:objects
    melissa adam - person
    mel-bailey-at-gmail-com phone-3383946795 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    adam-email - email
    query-adam - query
    amount-cart-total - amount
    supervisor-cart - cart
    request-cart-items - payment-request
  )
  (:init
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for amazon mel-bailey-at-gmail-com)
    (username-for phone phone-3383946795)
    (username-for venmo mel-bailey-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (cart-of-supervisor supervisor-cart)
    (cart-for supervisor-cart adam)
    (cart-subtotal supervisor-cart amount-cart-total)
    (contact-query adam query-adam)
    (contact-email adam adam-email)
  )
  (:goal (and
    (request-created request-cart-items adam amount-cart-total)
    (task-completed)
  ))
)
