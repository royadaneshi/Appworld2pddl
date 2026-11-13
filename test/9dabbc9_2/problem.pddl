(define (problem task-9dabbc9-2)
  (:domain appworld-9dabbc9-2)
  (:objects
    nancy roommate - person
    nan-ritt-at-gmail-com phone-2307354647 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    roommate-email - email
    relationship-roommate - relationship
    housing-request - payment-request
    amount-requested amount-corrected - amount
    note-rent-decreased-10-percent - note
  )
  (:init
    (credential-of-app phone phone-2307354647)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo nan-ritt-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for venmo nan-ritt-at-gmail-com)
    (username-for phone phone-2307354647)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (has-relationship roommate relationship-roommate)
    (email-of roommate roommate-email)
    (requested-by housing-request roommate)
    (request-amount housing-request amount-requested)
    (ten-percent-less amount-corrected amount-requested)
    (rent-decrease-note note-rent-decreased-10-percent)
  )
  (:goal (and
    (denied housing-request)
    (transaction-sent roommate amount-corrected note-rent-decreased-10-percent)
    (task-completed)
  ))
)
