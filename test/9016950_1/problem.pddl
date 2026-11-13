(define (problem task-9016950-1)
  (:domain appworld-9016950-1)
  (:objects
    andrew - person
    phone-user-8993579400 venmo-user-andrew-brow-at-gmail-com - username
    phone-password venmo-password new-password-a-2gm4r - password
    phone-token venmo-token - token
    parents - relationship
    parent-email-1 parent-email-2 - email
    parent-first-name-1 parent-last-name-1 parent-first-name-2 parent-last-name-2 - name
    parent-phone-1 parent-phone-2 - phone-number
    venmo-account-message - message
  )
  (:init
    (credential-of-app phone phone-user-8993579400)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-user-andrew-brow-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-user-8993579400)
    (username-for venmo venmo-user-andrew-brow-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (signup-password new-password-a-2gm4r)
    (notification-message venmo-account-message)
    (related parent-1 parents)
    (contact-email parent-1 parent-email-1)
    (contact-first-name parent-1 parent-first-name-1)
    (contact-last-name parent-1 parent-last-name-1)
    (contact-phone parent-1 parent-phone-1)
    (related parent-2 parents)
    (contact-email parent-2 parent-email-2)
    (contact-first-name parent-2 parent-first-name-2)
    (contact-last-name parent-2 parent-last-name-2)
    (contact-phone parent-2 parent-phone-2)
    (has-venmo-account parent-2))
  (:goal (and
    (has-venmo-account parent-1)
    (has-venmo-account parent-2)
    (text-sent parent-1)
    (task-completed)))
)
