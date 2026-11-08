(define (problem task-2d9f728-2)
  (:domain appworld-2d9f728-2)
  (:objects
    kathryn nancy roommate-2 - person
    username-2473084266 kathrynmaldonado-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    nancy-email roommate-2-email - email
    amount-taxi-share amount-food-share - amount
    note-taxi-fare note-dinner-bill - note
    relationship-roommate - relationship)
  (:init
    (username-for phone username-2473084266)
    (username-for venmo kathrynmaldonado-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate-relationship relationship-roommate)
    (is-roommate nancy)
    (is-roommate roommate-2)
    (food-payer nancy)
    (email-of nancy nancy-email)
    (email-of roommate-2 roommate-2-email)
    (taxi-share amount-taxi-share)
    (food-share amount-food-share)
    (taxi-note note-taxi-fare)
    (food-note note-dinner-bill))
  (:goal (and
    (taxi-requested nancy)
    (taxi-requested roommate-2)
    (dinner-paid nancy)
    (task-completed))))
