(define (problem task-9dabbc9-1)
  (:domain appworld-9dabbc9-1)
  (:objects
    paul roommate - person
    paul-mill-at-gmail-com phone-3379617841 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    roommate-email - email
    relationship-roommate - relationship
    housing-request - payment-request
    amount-original amount-corrected - amount
    note-you-forgot-about-the-5-percent-increase - note)
  (:init
    (username-for venmo paul-mill-at-gmail-com)
    (username-for phone phone-3379617841)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (token-for venmo venmo-token)
    (token-for phone phone-token)
    (has-relationship roommate relationship-roommate)
    (email-of roommate roommate-email)
    (requested-by housing-request roommate)
    (amount-of housing-request amount-original)
    (increased-by-5-percent amount-original amount-corrected))
  (:goal (and
    (denied housing-request)
    (sent roommate amount-corrected note-you-forgot-about-the-5-percent-increase)
    (task-completed))))
