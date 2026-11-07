(define (problem task-37a8675-1)
  (:domain appworld-37a8675-1)
  (:objects
    jessica-miller contact-2192158297 - person
    phone-number-3808719492 jes-mill-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    email-of-contact-2192158297 - email
    query-2192158297 - query
    amount-91 - amount
    privacy-private - privacy
    description-payment - description
    venmo-card-1 - payment-card
    txn-91-private-to-contact - transaction)
  (:init
    (login-username phone phone-number-3808719492)
    (login-username venmo jes-mill-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (contact-query query-2192158297 contact-2192158297)
    (email-of contact-2192158297 email-of-contact-2192158297)
    (txn-receiver txn-91-private-to-contact contact-2192158297)
    (txn-amount txn-91-private-to-contact amount-91)
    (txn-privacy txn-91-private-to-contact privacy-private))
  (:goal (and (transaction-sent txn-91-private-to-contact) (task-completed)))
)
