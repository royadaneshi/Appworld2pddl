(define (problem task-9016950-1)
  (:domain appworld-9016950-1)
  (:objects
    andrew - person
    phone-user-8993579400 venmo-user-andrew-brow-at-gmail-com - username
    phone-password venmo-password new-password-a-2gm4r - password
    phone-token venmo-token - token
    parents - relationship
    parent-1-email parent-2-email - email
    parent-1-first-name parent-1-last-name parent-2-first-name parent-2-last-name - name
    parent-1-phone parent-2-phone - phone-number
    venmo-account-message - message
  )
  (:init
    (username-for phone phone-user-8993579400)
    (username-for venmo venmo-user-andrew-brow-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (signup-password new-password-a-2gm4r)
    (notification-message venmo-account-message)
    (related parent-1 parents)
    (related parent-2 parents)
    (contact-email parent-1 parent-1-email)
    (contact-first-name parent-1 parent-1-first-name)
    (contact-last-name parent-1 parent-1-last-name)
    (contact-phone parent-1 parent-1-phone)
    (contact-email parent-2 parent-2-email)
    (contact-first-name parent-2 parent-2-first-name)
    (contact-last-name parent-2 parent-2-last-name)
    (contact-phone parent-2 parent-2-phone)
  )
  (:goal (and
    (has-venmo-account parent-1)
    (has-venmo-account parent-2)
    (text-sent parent-1)
    (text-sent parent-2)
    (task-completed)
  ))
)
