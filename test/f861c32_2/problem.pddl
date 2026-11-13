(define (problem task-f861c32-2)
  (:domain appworld-f861c32-2)
  (:objects
    connor coworker-1 coworker-2 coworker-3 coworker-4 coworker-5 coworker-6 coworker-7 - person
    coworker-1-email coworker-2-email coworker-3-email coworker-4-email coworker-5-email coworker-6-email coworker-7-email - email
    phone-username-5734599766 venmo-username-connorbrow-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    amount-20 amount-refill - amount
    note-for-lunch - note
    venmo-card - payment-card
    n0 n1 n2 n3 n4 n5 n6 n7 - count
    new-card-name new-card-owner new-card-number new-card-year new-card-month new-card-cvv - card-field
  )
  (:init
    (credential-of-app phone phone-username-5734599766)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-username-connorbrow-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-username-5734599766)
    (username-for venmo venmo-username-connorbrow-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship coworker-1 coworker)
    (has-relationship coworker-2 coworker)
    (has-relationship coworker-3 coworker)
    (has-relationship coworker-4 coworker)
    (has-relationship coworker-5 coworker)
    (has-relationship coworker-6 coworker)
    (has-relationship coworker-7 coworker)
    (email-of coworker-1 coworker-1-email)
    (email-of coworker-2 coworker-2-email)
    (email-of coworker-3 coworker-3-email)
    (email-of coworker-4 coworker-4-email)
    (email-of coworker-5 coworker-5-email)
    (email-of coworker-6 coworker-6-email)
    (email-of coworker-7 coworker-7-email)
    (payment-amount amount-20)
    (payment-note note-for-lunch)
    (refill-amount amount-refill)
    (payments-made n0)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (succ n3 n4)
    (succ n4 n5)
    (succ n5 n6)
    (succ n6 n7)
    (required-payments n7)
    (card-details venmo-card new-card-name new-card-owner new-card-number new-card-year new-card-month new-card-cvv)
  )
  (:goal (and
    (transaction-sent coworker-1 amount-20 note-for-lunch)
    (transaction-sent coworker-2 amount-20 note-for-lunch)
    (transaction-sent coworker-3 amount-20 note-for-lunch)
    (transaction-sent coworker-4 amount-20 note-for-lunch)
    (transaction-sent coworker-5 amount-20 note-for-lunch)
    (transaction-sent coworker-6 amount-20 note-for-lunch)
    (transaction-sent coworker-7 amount-20 note-for-lunch)
    (task-completed)))
)
