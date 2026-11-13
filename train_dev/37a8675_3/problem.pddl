(define (problem task-37a8675-3)
  (:domain appworld-37a8675-3)
  (:objects
    jared contact-2114992604 - person
    phone-3016947686 jar-calhoun-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    contact-email - email
    phone-2114992604 - phone-number
    query-2114992604 - query
    amount-68 - amount
    description-payment - description
    private-true - privacy
    card-nonexpired - payment-card
    tx-68-private - transaction)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-3016947686)
    (username-for venmo jar-calhoun-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-phone contact-2114992604 phone-2114992604)
    (query-for-phone query-2114992604 phone-2114992604)
    (email-of contact-2114992604 contact-email)
    (tx-receiver tx-68-private contact-2114992604)
    (tx-amount tx-68-private amount-68)
    (tx-privacy tx-68-private private-true))
  (:goal (and (transaction-sent tx-68-private) (task-completed)))
)
