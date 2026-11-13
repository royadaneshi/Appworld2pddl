(define (problem task-9016950-2)
  (:domain appworld-9016950-2)
  (:objects
    jordan roommate-1 roommate-2 roommate-3 - person
    phone-username-2254213734 venmo-username-jo-harr-at-gmail-com - username
    phone-password venmo-password temp-password-ko6a - password
    phone-token venmo-token - token
    relationship-roommate - relationship
    roommate-first-name-1 roommate-last-name-1 roommate-first-name-2 roommate-last-name-2 roommate-first-name-3 roommate-last-name-3 - name
    roommate-email-1 roommate-email-2 roommate-email-3 - email
    roommate-phone-1 roommate-phone-2 roommate-phone-3 - phone-number
    message-venmo-account-made - message
  )
  (:init
    (username-for phone phone-username-2254213734)
    (username-for venmo venmo-username-jo-harr-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (signup-password temp-password-ko6a)
    (notification-message message-venmo-account-made)
    (is-roommate roommate-1)
    (first-name-of roommate-1 roommate-first-name-1)
    (last-name-of roommate-1 roommate-last-name-1)
    (email-of roommate-1 roommate-email-1)
    (phone-of roommate-1 roommate-phone-1)
    (is-roommate roommate-2)
    (first-name-of roommate-2 roommate-first-name-2)
    (last-name-of roommate-2 roommate-last-name-2)
    (email-of roommate-2 roommate-email-2)
    (phone-of roommate-2 roommate-phone-2)
    (is-roommate roommate-3)
    (first-name-of roommate-3 roommate-first-name-3)
    (last-name-of roommate-3 roommate-last-name-3)
    (email-of roommate-3 roommate-email-3)
    (phone-of roommate-3 roommate-phone-3)
    (has-venmo-account roommate-2))
  (:goal (and
    (venmo-account-created roommate-1)
    (venmo-account-created roommate-3)
    (text-sent roommate-1)
    (text-sent roommate-3)
    (venmo-account-checked roommate-1)
    (venmo-account-checked roommate-2)
    (venmo-account-checked roommate-3)
    (task-completed))))
