(define (problem task-9016950-3)
  (:domain appworld-9016950-3)
  (:objects
    chelsea-burch parent-1 parent-2 - person
    phone-username-7763361246 venmo-username-chelsea-burch-at-gmail-com - username
    phone-password venmo-password pw-jy-a3u - password
    phone-token venmo-token - token
    relationship-parents - relationship
    parent-first-name-1 parent-first-name-2 - first-name
    parent-last-name-1 parent-last-name-2 - last-name
    parent-email-1 parent-email-2 - email
    parent-phone-number-1 parent-phone-number-2 - phone-number
    message-venmo-account-created - message
  )
  (:init
    (username-for phone phone-username-7763361246)
    (username-for venmo venmo-username-chelsea-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (parents-relationship relationship-parents)
    (new-account-password pw-jy-a3u)
    (notification-message message-venmo-account-created)
    (is-parent parent-1)
    (contact-first-name parent-1 parent-first-name-1)
    (contact-last-name parent-1 parent-last-name-1)
    (contact-email parent-1 parent-email-1)
    (contact-phone parent-1 parent-phone-number-1)
    (is-parent parent-2)
    (contact-first-name parent-2 parent-first-name-2)
    (contact-last-name parent-2 parent-last-name-2)
    (contact-email parent-2 parent-email-2)
    (contact-phone parent-2 parent-phone-number-2)
    (lacks-venmo-account parent-2))
  (:goal (and
    (venmo-account-created parent-2)
    (text-sent parent-2)
    (venmo-status-known parent-1)
    (venmo-status-known parent-2)
    (task-completed)))
)
