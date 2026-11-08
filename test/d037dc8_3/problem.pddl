(define (problem task-d037dc8-3)
  (:domain appworld-d037dc8-3)
  (:objects
    kathryn roommate-1 roommate-2 roommate-3 - person
    kathrynmaldonado-at-gmail-com phone-2473084266 - username
    amazon-password phone-password venmo-password - password
    amazon-token phone-token venmo-token - token
    roommate-1-email roommate-2-email roommate-3-email - email
    amount-share - amount
    note-for-amazon-orders - note
    relationship-roommate - relationship
    order-1 order-2 order-3 order-4 - order
    c0 c1 c2 c3 c4 - count)
  (:init
    (username-for amazon kathrynmaldonado-at-gmail-com)
    (username-for venmo kathrynmaldonado-at-gmail-com)
    (username-for phone phone-2473084266)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (recent-order order-1)
    (recent-order order-2)
    (recent-order order-3)
    (recent-order order-4)
    (totals-known-count c0)
    (succ c0 c1)
    (succ c1 c2)
    (succ c2 c3)
    (succ c3 c4)
    (num-recent-orders c4)
    (roommate-relationship relationship-roommate)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (is-roommate roommate-3)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email)
    (contact-email roommate-3 roommate-3-email)
    (share-amount amount-share)
    (request-note note-for-amazon-orders))
  (:goal (and
    (request-sent roommate-1)
    (request-sent roommate-2)
    (request-sent roommate-3)
    (task-completed)))
)
