(define (problem task-f861c32-1)
  (:domain appworld-f861c32-1)
  (:objects
    lindsey roommate-1 roommate-2 roommate-3 - person
    lindseysimpson-at-gmail-com phone-3567801924 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    roommate-1-email roommate-2-email roommate-3-email - email
    amount-30 amount-refill - amount
    note-for-drinks - note
    rel-roommate - relationship
    venmo-card - payment-card)
  (:init
    (username-for venmo lindseysimpson-at-gmail-com)
    (username-for phone phone-3567801924)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (has-relationship roommate-1 rel-roommate)
    (has-relationship roommate-2 rel-roommate)
    (has-relationship roommate-3 rel-roommate)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email)
    (contact-email roommate-3 roommate-3-email)
    (task-amount amount-30)
    (task-note note-for-drinks)
    (refill-amount amount-refill))
  (:goal (and
    (balance-refilled)
    (paid roommate-1 amount-30 note-for-drinks)
    (paid roommate-2 amount-30 note-for-drinks)
    (paid roommate-3 amount-30 note-for-drinks)
    (task-completed))))
