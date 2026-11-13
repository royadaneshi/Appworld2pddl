(define (problem task-60d0b5b-3)
  (:domain appworld-60d0b5b-3)
  (:objects
    patricia brandon - person
    username-2444880289 username-pa-ritter-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    brandon-email - email
    query-brandon - query
    status-approved - status
    desc-returning-the-accidental-payment - description
    amount-of-last-request-to-brandon - amount
    last-approved-request-to-brandon - payment-request
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (login-username phone username-2444880289)
    (login-username venmo username-pa-ritter-at-gmail-com)
    (contact-query brandon query-brandon)
    (email-of brandon brandon-email)
    (approved-status status-approved)
    (refund-description desc-returning-the-accidental-payment)
    (latest-approved-request brandon last-approved-request-to-brandon)
    (request-amount last-approved-request-to-brandon amount-of-last-request-to-brandon)
  )
  (:goal (and
    (transaction-sent brandon amount-of-last-request-to-brandon)
    (task-completed)
  ))
)
