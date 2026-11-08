(define (problem task-9016950-3)
  (:domain appworld-9016950-3)
  (:objects
    chelsea-burch parent-1 parent-2 - person
    phone-username-7763361246 venmo-username-chelsea-burch-at-gmail-com - username
    phone-password venmo-password pw-jy-a3u - password
    phone-token venmo-token - token
    relationship-parents - relationship
    parent-1-first-name parent-2-first-name - first-name
    parent-1-last-name parent-2-last-name - last-name
    parent-1-email parent-2-email - email
    parent-1-phone-number parent-2-phone-number - phone-number
    message-venmo-account-created - message)
  (:init
    (username-for phone phone-username-7763361246)
    (username-for venmo venmo-username-chelsea-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (is-parent parent-1)
    (is-parent parent-2)
    (parents-relationship relationship-parents)
    (contact-first-name parent-1 parent-1-first-name)
    (contact-first-name parent-2 parent-2-first-name)
    (contact-last-name parent-1 parent-1-last-name)
    (contact-last-name parent-2 parent-2-last-name)
    (contact-email parent-1 parent-1-email)
    (contact-email parent-2 parent-2-email)
    (contact-phone parent-1 parent-1-phone-number)
    (contact-phone parent-2 parent-2-phone-number)
    (new-account-password pw-jy-a3u)
    (notification-message message-venmo-account-created)
    (lacks-venmo-account parent-1)
    (lacks-venmo-account parent-2))
  (:goal (and
    (venmo-account-created parent-1)
    (venmo-account-created parent-2)
    (text-sent parent-1)
    (text-sent parent-2)
    (task-completed)))
)
