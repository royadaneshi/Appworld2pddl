(define (problem task-f861c32-2)
  (:domain appworld-f861c32-2)
  (:objects
    connor coworker-1 coworker-2 coworker-3 coworker-4 - person
    coworker-1-email coworker-2-email coworker-3-email coworker-4-email - email
    phone-username-5734599766 venmo-username-connorbrow-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    amount-20 amount-refill - amount
    note-for-lunch - note
    venmo-card - payment-card
    n0 n1 n2 n3 n4 - count)
  (:init
    (username-for phone phone-username-5734599766)
    (username-for venmo venmo-username-connorbrow-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship coworker-1 coworker)
    (has-relationship coworker-2 coworker)
    (has-relationship coworker-3 coworker)
    (has-relationship coworker-4 coworker)
    (email-of coworker-1 coworker-1-email)
    (email-of coworker-2 coworker-2-email)
    (email-of coworker-3 coworker-3-email)
    (email-of coworker-4 coworker-4-email)
    (payment-amount amount-20)
    (payment-note note-for-lunch)
    (refill-amount amount-refill)
    (payments-made n0)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (succ n3 n4)
    (required-payments n4))
  (:goal (and
    (transaction-sent coworker-1 amount-20 note-for-lunch)
    (transaction-sent coworker-2 amount-20 note-for-lunch)
    (transaction-sent coworker-3 amount-20 note-for-lunch)
    (transaction-sent coworker-4 amount-20 note-for-lunch)
    (task-completed)))
)
