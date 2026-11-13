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
    jordan-harrison roommate-kathryn-maldonado roommate-troy-solomon roommate-nancy-ritter - person
    email-kathryn-maldonado email-troy-solomon email-nancy-ritter - email
    tx-8319 tx-8320 tx-8327 tx-8328 tx-8329 tx-8335 tx-8339 tx-8341 - transaction
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
    (is-roommate roommate-kathryn-maldonado)
    (is-roommate roommate-troy-solomon)
    (is-roommate roommate-nancy-ritter)
    (contact-email roommate-kathryn-maldonado email-kathryn-maldonado)
    (contact-email roommate-troy-solomon email-troy-solomon)
    (contact-email roommate-nancy-ritter email-nancy-ritter)
    (received-from tx-8319 roommate-kathryn-maldonado)
    (received-from tx-8320 roommate-troy-solomon)
    (received-from tx-8327 roommate-troy-solomon)
    (received-from tx-8328 roommate-kathryn-maldonado)
    (received-from tx-8329 roommate-nancy-ritter)
    (received-from tx-8335 roommate-nancy-ritter)
    (received-from tx-8339 roommate-kathryn-maldonado)
    (received-from tx-8341 roommate-nancy-ritter)
    (in-window tx-8319)
    (in-window tx-8320)
    (in-window tx-8327)
    (in-window tx-8328)
    (in-window tx-8329)
    (in-window tx-8335)
    (in-window tx-8339)
    (in-window tx-8341))
  (:goal (and
    (liked tx-8319)
    (liked tx-8320)
    (liked tx-8327)
    (liked tx-8328)
    (liked tx-8329)
    (liked tx-8335)
    (liked tx-8339)
    (liked tx-8341)
    (commented tx-8319 comment-thank-you-so-much)
    (commented tx-8320 comment-thank-you-so-much)
    (commented tx-8327 comment-thank-you-so-much)
    (commented tx-8328 comment-thank-you-so-much)
    (commented tx-8329 comment-thank-you-so-much)
    (commented tx-8335 comment-thank-you-so-much)
    (commented tx-8339 comment-thank-you-so-much)
    (commented tx-8341 comment-thank-you-so-much)
    (task-completed)))
)
