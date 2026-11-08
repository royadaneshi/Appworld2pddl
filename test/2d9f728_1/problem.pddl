(define (problem task-2d9f728-1)
  (:domain appworld-2d9f728-1)
  (:objects
    troy nancy roommate-2 - person
    username-7273731063 tr-solo-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    nancy-email roommate-2-email - email
    amount-20 amount-42-67 - amount
    note-for-taxi note-for-food - note)
  (:init
    (username-for phone username-7273731063)
    (username-for venmo tr-solo-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship nancy roommate)
    (has-relationship roommate-2 roommate)
    (contact-email nancy nancy-email)
    (contact-email roommate-2 roommate-2-email)
    (food-payer nancy)
    (taxi-note note-for-taxi)
    (food-note note-for-food)
    (taxi-share amount-20)
    (food-share amount-42-67))
  (:goal (and
    (payment-requested nancy note-for-taxi amount-20)
    (payment-requested roommate-2 note-for-taxi amount-20)
    (payment-sent nancy note-for-food amount-42-67)
    (task-completed))))
