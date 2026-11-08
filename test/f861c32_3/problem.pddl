(define (problem task-f861c32-3)
  (:domain appworld-f861c32-3)
  (:objects
    anthony-harrison friend-1 friend-2 friend-3 friend-4 - person
    phone-username-2466064078 venmo-username-an-harrison-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    friend-1-email friend-2-email friend-3-email friend-4-email - email
    amount-20 amount-refill - amount
    note-for-karaoke - note
    relationship-friend - relationship
    venmo-card-1 - card
    count-1 count-2 count-3 count-4 - count)
  (:init
    (login-username phone phone-username-2466064078)
    (login-username venmo venmo-username-an-harrison-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (friend-relationship relationship-friend)
    (is-friend friend-1)
    (is-friend friend-2)
    (is-friend friend-3)
    (is-friend friend-4)
    (contact-email friend-1 friend-1-email)
    (contact-email friend-2 friend-2-email)
    (contact-email friend-3 friend-3-email)
    (contact-email friend-4 friend-4-email)
    (payment-amount amount-20)
    (payment-note note-for-karaoke)
    (refill-amount amount-refill)
    (remaining-payments count-4)
    (decrement count-4 count-3)
    (decrement count-3 count-2)
    (decrement count-2 count-1)
    (decrement count-1 zero))
  (:goal (and (remaining-payments zero) (task-completed))))
