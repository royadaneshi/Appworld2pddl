(define (problem task-fa327a6-1)
  (:domain appworld-fa327a6-1)
  (:objects
    norman brenda - person
    phone-5708520672 normansmit-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    brenda-email - email
    query-brenda - query
    relationship-friend - relationship
    order-latest order-second-latest - order
    amount-difference - amount
    datetime-2023-05-18t00-00-00 - datetime
    direction-received - txn-direction
    note-fixing-amazon-order-payment - note)
  (:init
    (username-for phone phone-5708520672)
    (username-for amazon normansmit-at-gmail-com)
    (username-for venmo normansmit-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (token-for venmo venmo-token)
    (contact-query brenda query-brenda)
    (contact-relationship brenda relationship-friend)
    (email-of brenda brenda-email)
    (last-two-orders order-latest order-second-latest)
    (underpaid brenda amount-difference))
  (:goal (and
    (difference-settled brenda amount-difference note-fixing-amazon-order-payment)
    (task-completed))))
