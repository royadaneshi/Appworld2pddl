(define (problem task-afc0fce-3)
  (:domain appworld-afc0fce-3)
  (:objects
    jordan-harrison roommate-a roommate-b - person
    phone-number-2254213734 jo-harr-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    roommate-a-email roommate-b-email - email
    query-roommate - query
    relationship-roommate - relationship
    datetime-2023-05-24 - datetime
    direction-received - direction
    txn-a0 txn-a1 txn-a2 txn-b1 - transaction
    comment-thank-you-so-much - comment-text)
  (:init
    (username-for phone phone-number-2254213734)
    (username-for venmo jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (target-query query-roommate)
    (target-relationship relationship-roommate)
    (is-roommate roommate-a)
    (is-roommate roommate-b)
    (contact-email roommate-a roommate-a-email)
    (contact-email roommate-b roommate-b-email)
    (min-created-at datetime-2023-05-24)
    (received-direction direction-received)
    (received-from txn-a0 roommate-a)
    (received-from txn-a1 roommate-a)
    (received-from txn-a2 roommate-a)
    (received-from txn-b1 roommate-b)
    (in-window txn-a1)
    (in-window txn-a2)
    (in-window txn-b1)
    (target-comment comment-thank-you-so-much))
  (:goal (and
    (liked txn-a1) (commented txn-a1 comment-thank-you-so-much)
    (liked txn-a2) (commented txn-a2 comment-thank-you-so-much)
    (liked txn-b1) (commented txn-b1 comment-thank-you-so-much)
    (task-completed)))
)
