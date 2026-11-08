(define (problem task-9016950-2)
  (:domain appworld-9016950-2)
  (:objects
    jordan roommate-1 roommate-2 - person
    phone-username-2254213734 venmo-username-jo-harr-at-gmail-com - username
    phone-password venmo-password temp-password-ko6a - password
    phone-token venmo-token - token
    relationship-roommate - relationship
    roommate-1-first-name roommate-1-last-name roommate-2-first-name roommate-2-last-name - name
    roommate-1-email roommate-2-email - email
    roommate-1-phone roommate-2-phone - phone-number
    message-venmo-account-made - message)
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
    (is-roommate roommate-2)
    (first-name-of roommate-1 roommate-1-first-name)
    (last-name-of roommate-1 roommate-1-last-name)
    (email-of roommate-1 roommate-1-email)
    (phone-of roommate-1 roommate-1-phone)
    (first-name-of roommate-2 roommate-2-first-name)
    (last-name-of roommate-2 roommate-2-last-name)
    (email-of roommate-2 roommate-2-email)
    (phone-of roommate-2 roommate-2-phone))
  (:goal (and
    (venmo-account-created roommate-1)
    (venmo-account-created roommate-2)
    (text-sent roommate-1)
    (text-sent roommate-2)
    (task-completed))))
