(define (problem task-ff58e36-2)
  (:domain appworld-ff58e36-2)
  (:objects
    chris coworker-1 coworker-2 friend-1 - person
    coworker friend - relationship
    chris-mcco-at-gmail-com phone-5584932120 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    coworker-1-email coworker-2-email friend-1-email - email)
  (:init
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (username-for venmo chris-mcco-at-gmail-com)
    (username-for phone phone-5584932120)
    (token-for venmo venmo-token)
    (token-for phone phone-token)
    (has-relationship coworker-1 coworker)
    (has-relationship coworker-2 coworker)
    (has-relationship friend-1 friend)
    (contact-email coworker-1 coworker-1-email)
    (contact-email coworker-2 coworker-2-email)
    (contact-email friend-1 friend-1-email)
    (venmo-friend coworker-2))
  (:goal (and
    (venmo-friend coworker-1)
    (venmo-friend coworker-2)
    (venmo-friend friend-1)
    (task-completed))))
