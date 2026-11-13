(define (problem task-9dabbc9-3)
  (:domain appworld-9dabbc9-3)
  (:objects
    nicholas roommate - person
    nicholas-weber-at-gmail-com phone-number-9503658964 - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    roommate-email - email
    rel-roommate - relationship
    housing-request - payment-request
    amount-corrected - amount
    note-correcting-for-15-percent-rent-increase - note)
  (:init
    (credential-of-app phone phone-number-9503658964)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo nicholas-weber-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-9503658964)
    (username-for venmo nicholas-weber-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship roommate rel-roommate)
    (contact-email roommate roommate-email)
    (requested-by housing-request roommate)
    (corrected-amount housing-request amount-corrected)
    (correction-note note-correcting-for-15-percent-rent-increase))
  (:goal (and
    (denied housing-request)
    (transaction-sent roommate amount-corrected note-correcting-for-15-percent-rent-increase)
    (task-completed))))
