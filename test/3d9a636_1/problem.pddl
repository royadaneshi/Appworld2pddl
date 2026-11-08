(define (problem task-3d9a636-1)
  (:domain appworld-3d9a636-1)
  (:objects
    anita-burch - person
    phone-3643463570 anita-burch-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    contact-not-friend-1-email contact-not-friend-2-email friend-not-contact-1-email - email)
  (:init
    (username-for phone phone-3643463570)
    (username-for venmo anita-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (phone-contact contact-not-friend-1)
    (phone-contact contact-not-friend-2)
    (phone-contact contact-and-friend-1)
    (venmo-friend contact-and-friend-1)
    (venmo-friend friend-not-contact-1)
    (email-of contact-not-friend-1 contact-not-friend-1-email)
    (email-of contact-not-friend-2 contact-not-friend-2-email)
    (email-of friend-not-contact-1 friend-not-contact-1-email))
  (:goal (and
    (venmo-friend contact-not-friend-1)
    (venmo-friend contact-not-friend-2)
    (venmo-friend contact-and-friend-1)
    (not (venmo-friend friend-not-contact-1))
    (task-completed)))
)
