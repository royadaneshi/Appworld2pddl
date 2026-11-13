(define (problem task-2d9f728-1)
  (:domain appworld-2d9f728-1)
  (:objects
    username-7273731063 tr-solo-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    amount-1 amount-2 - amount
    note-for-taxi note-for-food - note
    troy nancy person-1 roommate-2 - person
    nancy-email roommate-email-1 roommate-email-2 - email
  )
  (:init
    (credential-of-app phone username-7273731063)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo tr-solo-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-7273731063)
    (username-for venmo tr-solo-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship nancy roommate)
    (has-relationship person-1 roommate) (has-relationship roommate-2 roommate)
    (contact-email nancy nancy-email)
    (contact-email person-1 roommate-email-1) (contact-email roommate-2 roommate-email-2)
    (food-payer nancy)
    (taxi-note note-for-taxi)
    (food-note note-for-food)
    (taxi-share amount-1)
    (food-share amount-2))
  (:goal (and
    (payment-requested nancy note-for-taxi amount-1)
    (payment-requested person-1 note-for-taxi amount-1) (payment-requested roommate-2 note-for-taxi amount-1)
    (payment-sent nancy note-for-food amount-2)
    (task-completed))))
