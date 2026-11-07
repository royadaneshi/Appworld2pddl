(define (problem task-60d0b5b-1)
  (:domain appworld-60d0b5b-1)
  (:objects
    tammy robert - person
    tammy-phone-2738013302 tammy-email-ta-weav-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    robert-email - email
    query-robert - query
    status-approved - status
    accidental-request - payment-request
    amount-of-accidental-request - amount
    note-returning-the-accidental-payment - description
  )
  (:init
    (username-for phone tammy-phone-2738013302)
    (username-for venmo tammy-email-ta-weav-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (contact-query robert query-robert)
    (email-of robert robert-email)
    (approved-status status-approved)
    (last-approved-request accidental-request robert)
    (request-amount accidental-request amount-of-accidental-request)
    (refund-description note-returning-the-accidental-payment)
  )
  (:goal (and
    (refunded accidental-request robert amount-of-accidental-request)
    (task-completed)
  ))
)
