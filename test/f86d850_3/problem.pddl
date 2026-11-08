(define (problem task-f86d850-3)
  (:domain appworld-f86d850-3)
  (:objects
    katherine nicholas - person
    ka-ball-at-gmail-com - username
    amazon-password gmail-password venmo-password - password
    amazon-token gmail-token venmo-token - token
    query-amazon-kindle-9th-generation query-amazon-order-confirmation query-nicholas - query
    kindle-9th-generation - product
    katherine-payment-card - payment-card
    katherine-address - address
    kindle-order - order
    order-total-amount - amount
    confirmation-thread - email-thread
    confirmation-email - email-msg
    nicholas-email - email
    note-order-on-amazon - note
  )
  (:init
    (username-for amazon ka-ball-at-gmail-com)
    (username-for gmail ka-ball-at-gmail-com)
    (username-for venmo ka-ball-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for gmail gmail-password)
    (password-for venmo venmo-password)
    (product-query query-amazon-kindle-9th-generation kindle-9th-generation)
    (confirmation-query query-amazon-order-confirmation)
    (person-query query-nicholas nicholas)
    (email-of nicholas nicholas-email)
  )
  (:goal (and
    (order-placed kindle-order kindle-9th-generation)
    (forwarded kindle-order nicholas)
    (payment-requested nicholas kindle-order note-order-on-amazon)
    (task-completed)
  ))
)
