(define (problem task-3d9a636-2)
  (:domain appworld-3d9a636-2)
  (:objects
    claudia-miller - person
    phone-username-2125442118 venmo-username-clmiller-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    relationship-friend - relationship
    contact-friend-1-email contact-friend-2-email venmo-only-friend-1-email mutual-friend-1-email - email
  )
  (:init
    (username-for phone phone-username-2125442118)
    (username-for venmo venmo-username-clmiller-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (phone-friend contact-friend-1)
    (phone-friend contact-friend-2)
    (phone-friend mutual-friend-1)
    (venmo-friend venmo-only-friend-1)
    (venmo-friend mutual-friend-1)
    (email-of contact-friend-1 contact-friend-1-email)
    (email-of contact-friend-2 contact-friend-2-email)
    (email-of venmo-only-friend-1 venmo-only-friend-1-email)
    (email-of mutual-friend-1 mutual-friend-1-email)
  )
  (:goal (and
    (venmo-friend contact-friend-1)
    (venmo-friend contact-friend-2)
    (venmo-friend mutual-friend-1)
    (not (venmo-friend venmo-only-friend-1))
    (task-completed)
  ))
)
