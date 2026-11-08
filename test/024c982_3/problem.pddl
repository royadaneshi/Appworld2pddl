(define (problem task-024c982-3)
  (:domain appworld-024c982-3)
  (:objects
    david ronald - person
    dav-mart-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    ronald-email - email
    query-ronald - query
    amount-29 - amount
    note-for-the-road-trip - note
    private-false - privacy
    req-ronald-road-trip - payment-request
  )
  (:init
    (password-for venmo venmo-password)
    (username-for venmo dav-mart-at-gmail-com)
    (friend ronald)
    (email-of ronald ronald-email)
    (query-for query-ronald ronald)
    (request-target req-ronald-road-trip ronald)
    (request-amount req-ronald-road-trip amount-29)
    (request-note req-ronald-road-trip note-for-the-road-trip)
    (request-privacy req-ronald-road-trip private-false)
  )
  (:goal (and
    (request-created req-ronald-road-trip)
    (task-completed)
  ))
)
