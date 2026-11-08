(define (problem task-024c982-1)
  (:domain appworld-024c982-1)
  (:objects
    joyce - person
    stacy - person
    joyce-weav-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    stacy-email - email
    query-stacy - query
    amount-13 - amount
    note-for-yesterdays-meal - note
    privacy-public - privacy
    request-stacy-13 - payment-request
  )
  (:init
    (username-for venmo joyce-weav-at-gmail-com)
    (password-for venmo venmo-password)
    (query-for stacy query-stacy)
    (email-of stacy stacy-email)
    (request-to request-stacy-13 stacy)
    (request-amount request-stacy-13 amount-13)
    (request-note request-stacy-13 note-for-yesterdays-meal)
    (request-privacy request-stacy-13 privacy-public)
  )
  (:goal (and
    (request-created request-stacy-13)
    (task-completed)
  ))
)
