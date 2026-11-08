(define (problem task-ff58e36-1)
  (:domain appworld-ff58e36-1)
  (:objects
    nancy-ritter - person
    phone-2307354647 nan-ritt-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    rel-friend rel-roommate - relationship
    friend-1-email friend-2-email roommate-1-email roommate-2-email - email
  )
  (:init
    (username-for phone phone-2307354647)
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (contact-relationship friend-1 rel-friend)
    (contact-relationship friend-2 rel-friend)
    (contact-relationship roommate-1 rel-roommate)
    (contact-relationship roommate-2 rel-roommate)
    (contact-email friend-1 friend-1-email)
    (contact-email friend-2 friend-2-email)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email)
    (venmo-friend friend-2)
  )
  (:goal (and
    (venmo-friend friend-1)
    (venmo-friend friend-2)
    (venmo-friend roommate-1)
    (venmo-friend roommate-2)
    (task-completed)
  ))
)
