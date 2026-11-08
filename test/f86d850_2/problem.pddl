(define (problem task-f86d850-2)
  (:domain appworld-f86d850-2)
  (:objects
    norman denise - person
    normansmit-at-gmail-com phone-5708520672 - username
    amazon-password gmail-password venmo-password phone-password - password
    amazon-token gmail-token venmo-token phone-token - token
    denise-email - email
    query-denise query-nintendo-switch-lite query-amazon-order-confirmation - query
    nintendo-switch-lite - product
    quantity-1 - quantity
    supervisor-payment-card - payment-card
    supervisor-address - address
    new-order - order
    order-total-amount - amount
    note-amazon-order - note
    confirmation-thread - email-thread
    confirmation-email - email-message
  )
  (:init
    (username-for amazon normansmit-at-gmail-com)
    (username-for gmail normansmit-at-gmail-com)
    (username-for venmo normansmit-at-gmail-com)
    (username-for phone phone-5708520672)
    (password-for amazon amazon-password)
    (password-for gmail gmail-password)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (contact-query query-denise denise)
    (email-of denise denise-email)
    (product-query query-nintendo-switch-lite nintendo-switch-lite)
    (order-total new-order order-total-amount)
    (email-query query-amazon-order-confirmation confirmation-thread)
    (confirmation-thread-of new-order confirmation-thread)
    (email-in-thread confirmation-thread confirmation-email)
  )
  (:goal (and
    (order-placed new-order)
    (ordered nintendo-switch-lite)
    (forwarded confirmation-email denise)
    (payment-requested denise order-total-amount note-amazon-order)
    (task-completed)
  ))
)
