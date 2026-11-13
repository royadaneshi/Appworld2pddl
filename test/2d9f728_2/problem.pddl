(define (problem task-2d9f728-2)
  (:domain appworld-2d9f728-2)
  (:objects
    username-2473084266 kathrynmaldonado-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    amount-taxi-share amount-food-share - amount
    note-taxi-fare note-dinner-bill - note
    relationship-roommate - relationship
    kathryn nancy roommate-1 roommate-2 - person
    nancy-email roommate-email-1 roommate-email-2 - email
  )
  (:init
    (credential-of-app phone username-2473084266)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo kathrynmaldonado-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-2473084266)
    (username-for venmo kathrynmaldonado-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate-relationship relationship-roommate)
    (is-roommate nancy)
    (is-roommate roommate-1) (is-roommate roommate-2)
    (food-payer nancy)
    (email-of nancy nancy-email)
    (email-of roommate-1 roommate-email-1) (email-of roommate-2 roommate-email-2)
    (taxi-share amount-taxi-share)
    (food-share amount-food-share)
    (taxi-note note-taxi-fare)
    (food-note note-dinner-bill))
  (:goal (and
    (taxi-requested nancy)
    (taxi-requested roommate-1) (taxi-requested roommate-2)
    (dinner-paid nancy)
    (task-completed))))
