(define (problem task-22cc237-3)
  (:domain appworld-22cc237-3)
  (:objects
    grant-martinez - person
    phone-7056722825 gra-martinez-at-gmail-com - username
    phone-password simple-note-password venmo-password - password
    phone-token simple-note-token venmo-token - token
    query-coworker query-dinner-with-colleagues - query
    relationship-coworker - relationship
    note-dinner-with-colleagues - note
    description-dinner-with-colleagues - description
    received - direction
    date-2023-05-19 - datetime
    amount-share-1 amount-share-2 amount-share-3 amount-share-4 amount-share-5 amount-share-6 amount-share-7 amount-share-8 amount-share-9 - amount
    email-coworker-1 email-coworker-2 email-coworker-3 email-coworker-4 email-coworker-5 email-coworker-6 email-coworker-7 email-coworker-8 email-coworker-9 - email
  )
  (:init
    (username-for phone phone-7056722825)
    (username-for simple-note gra-martinez-at-gmail-com)
    (username-for venmo gra-martinez-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for simple-note simple-note-token)
    (token-for venmo venmo-token)
    (contact-query query-coworker)
    (contact-relationship relationship-coworker)
    (note-query query-dinner-with-colleagues)
    (note-for-query note-dinner-with-colleagues query-dinner-with-colleagues)
    (request-description description-dinner-with-colleagues)
    (direction-received received)
    (date-yesterday date-2023-05-19)
    (coworker-email coworker-1 email-coworker-1)
    (coworker-email coworker-2 email-coworker-2)
    (coworker-email coworker-3 email-coworker-3)
    (coworker-email coworker-5 email-coworker-4)
    (coworker-email coworker-6 email-coworker-5)
    (coworker-email coworker-7 email-coworker-6)
    (coworker-email coworker-8 email-coworker-7)
    (coworker-email coworker-4 email-coworker-8)
    (coworker-email coworker-9 email-coworker-9)
    (share-in-note note-dinner-with-colleagues coworker-1 amount-share-1)
    (share-in-note note-dinner-with-colleagues coworker-2 amount-share-2)
    (share-in-note note-dinner-with-colleagues coworker-3 amount-share-3)
    (share-in-note note-dinner-with-colleagues coworker-5 amount-share-4)
    (share-in-note note-dinner-with-colleagues coworker-6 amount-share-5)
    (share-in-note note-dinner-with-colleagues coworker-7 amount-share-6)
    (share-in-note note-dinner-with-colleagues coworker-8 amount-share-7)
    (share-in-note note-dinner-with-colleagues coworker-4 amount-share-8)
    (share-in-note note-dinner-with-colleagues coworker-9 amount-share-9)
    (already-paid coworker-5)
    (already-paid coworker-6)
    (already-paid coworker-7)
    (already-paid coworker-8)
    (already-paid coworker-9))
  (:goal (and
    (payment-requested coworker-1)
    (payment-requested coworker-2)
    (payment-requested coworker-3)
    (payment-requested coworker-4)
    (not (payment-requested coworker-5))
    (not (payment-requested coworker-6))
    (not (payment-requested coworker-7))
    (not (payment-requested coworker-8))
    (not (payment-requested coworker-9))
    (task-completed)))
)
