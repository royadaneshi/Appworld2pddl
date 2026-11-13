(define (problem task-afc0fce-3)
  (:domain appworld-afc0fce-3)
  (:objects
    phone-number-2254213734 jo-harr-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate - query
    relationship-roommate - relationship
    datetime-2023-05-24 - datetime
    direction-received - direction
    comment-thank-you-so-much - comment-text
    jordan-harrison roommate-1 roommate-2 roommate-3 - person
    roommate-email-1 roommate-email-2 roommate-email-3 - email
    txn-a1-1 txn-a1-2 txn-a1-3 txn-a1-4 txn-a1-5 txn-a1-6 txn-a1-7 txn-a1-8 - transaction
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-2254213734)
    (username-for venmo jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (target-query query-roommate)
    (target-relationship relationship-roommate)
    (min-created-at datetime-2023-05-24)
    (received-direction direction-received)
    (target-comment comment-thank-you-so-much)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (is-roommate roommate-3)
    (contact-email roommate-1 roommate-email-1)
    (contact-email roommate-2 roommate-email-2)
    (contact-email roommate-3 roommate-email-3)
    (received-from txn-a1-1 roommate-1)
    (received-from txn-a1-2 roommate-2)
    (received-from txn-a1-3 roommate-2)
    (received-from txn-a1-4 roommate-1)
    (received-from txn-a1-5 roommate-3)
    (received-from txn-a1-6 roommate-3)
    (received-from txn-a1-7 roommate-1)
    (received-from txn-a1-8 roommate-3)
    (in-window txn-a1-1)
    (in-window txn-a1-2)
    (in-window txn-a1-3)
    (in-window txn-a1-4)
    (in-window txn-a1-5)
    (in-window txn-a1-6)
    (in-window txn-a1-7)
    (in-window txn-a1-8))
  (:goal (and
    (liked txn-a1-1)
    (liked txn-a1-2)
    (liked txn-a1-3)
    (liked txn-a1-4)
    (liked txn-a1-5)
    (liked txn-a1-6)
    (liked txn-a1-7)
    (liked txn-a1-8)
    (commented txn-a1-1 comment-thank-you-so-much)
    (commented txn-a1-2 comment-thank-you-so-much)
    (commented txn-a1-3 comment-thank-you-so-much)
    (commented txn-a1-4 comment-thank-you-so-much)
    (commented txn-a1-5 comment-thank-you-so-much)
    (commented txn-a1-6 comment-thank-you-so-much)
    (commented txn-a1-7 comment-thank-you-so-much)
    (commented txn-a1-8 comment-thank-you-so-much)
    (task-completed)))
)
