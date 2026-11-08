(define (problem task-d6d8cb6-3)
  (:domain appworld-d6d8cb6-3)
  (:objects
    jeffery - person
    diwils-at-gmail-com username-3966728840 - username
    amazon-password gmail-password phone-password - password
    amazon-token gmail-token phone-token - token
    query-vitamix query-jeffery query-return-confirmation - query
    order-vitamix-this-week - order
    product-vitamix-e310 - product
    deliverer-fedex - deliverer
    quantity-1 - quantity
    thread-return-confirmation - email-thread
    email-return-confirmation - email
    jeffery-email-address - email-address)
  (:init
    (username-for amazon diwils-at-gmail-com)
    (username-for gmail diwils-at-gmail-com)
    (username-for phone username-3966728840)
    (password-for amazon amazon-password)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (order-matches-query order-vitamix-this-week query-vitamix)
    (order-contains order-vitamix-this-week product-vitamix-e310)
    (confirmation-thread-of order-vitamix-this-week thread-return-confirmation)
    (thread-matches-query thread-return-confirmation query-return-confirmation)
    (email-in-thread email-return-confirmation thread-return-confirmation)
    (contact-matches-query jeffery query-jeffery)
    (email-address-of jeffery jeffery-email-address))
  (:goal (and
    (return-initiated order-vitamix-this-week product-vitamix-e310 deliverer-fedex quantity-1)
    (forwarded email-return-confirmation jeffery-email-address)
    (task-completed))))
