(define (problem task-f861c32-3)
  (:domain appworld-f861c32-3)
  (:objects
    anthony-harrison friend-1 friend-2 friend-3 friend-4 friend-5 friend-6 friend-7 friend-8 - person
    phone-username-2466064078 venmo-username-an-harrison-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    friend-1-email friend-2-email friend-3-email friend-4-email friend-5-email friend-6-email friend-7-email friend-8-email - email
    amount-20 amount-refill - amount
    note-for-karaoke - note
    relationship-friend - relationship
    venmo-card-1 - card
    count-1 count-2 count-3 count-4 count-5 count-6 count-7 count-8 - count
    new-card-name new-card-owner new-card-number new-card-year new-card-month new-card-cvv - card-field
  )
  (:init
    (credential-of-app phone phone-username-2466064078)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-username-an-harrison-at-gmail-com)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (login-username phone phone-username-2466064078)
    (login-username venmo venmo-username-an-harrison-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (friend-relationship relationship-friend)
    (is-friend friend-1)
    (is-friend friend-2)
    (is-friend friend-3)
    (is-friend friend-4)
    (is-friend friend-5)
    (is-friend friend-6)
    (is-friend friend-7)
    (is-friend friend-8)
    (contact-email friend-1 friend-1-email)
    (contact-email friend-2 friend-2-email)
    (contact-email friend-3 friend-3-email)
    (contact-email friend-4 friend-4-email)
    (contact-email friend-5 friend-5-email)
    (contact-email friend-6 friend-6-email)
    (contact-email friend-7 friend-7-email)
    (contact-email friend-8 friend-8-email)
    (payment-amount amount-20)
    (payment-note note-for-karaoke)
    (refill-amount amount-refill)
    (remaining-payments count-8)
    (decrement count-1 zero)
    (decrement count-2 count-1)
    (decrement count-3 count-2)
    (decrement count-4 count-3)
    (decrement count-5 count-4)
    (decrement count-6 count-5)
    (decrement count-7 count-6)
    (decrement count-8 count-7)
    (card-details venmo-card-1 new-card-name new-card-owner new-card-number new-card-year new-card-month new-card-cvv)
  )
  (:goal (and
    (remaining-payments zero)
    (task-completed))))
