(define (problem task-d18139b-1)
  (:domain appworld-d18139b-1)
  (:objects
    jose-harrison roommate-1 roommate-2 roommate-3 - person
    pr-1 pr-2 pr-3 pr-4 pr-5 pr-6 pr-7 pr-earlier-month - payment-request
    phone-username venmo-username - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    relationship-roommate - relationship
    status-pending - status
    venmo-card - payment-card
    topup-amount - amount
  )
  (:init
    (credential-of-app phone phone-username)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-username)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-username)
    (username-for venmo venmo-username)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate roommate-1)
    (request-from pr-1 roommate-1)
    (request-this-month pr-1)
    (request-pending pr-1)
    (request-from pr-2 roommate-1)
    (request-this-month pr-2)
    (request-pending pr-2)
    (request-from pr-3 roommate-1)
    (request-this-month pr-3)
    (request-pending pr-3)
    (roommate roommate-2)
    (request-from pr-4 roommate-2)
    (request-this-month pr-4)
    (request-pending pr-4)
    (request-from pr-5 roommate-2)
    (request-this-month pr-5)
    (request-pending pr-5)
    (request-from pr-6 roommate-2)
    (request-this-month pr-6)
    (request-pending pr-6)
    (roommate roommate-3)
    (request-from pr-7 roommate-3)
    (request-this-month pr-7)
    (request-pending pr-7)
    (request-from pr-earlier-month roommate-1)
    (request-pending pr-earlier-month)
    (usable-card venmo-card)
    (shortfall topup-amount)
  )
  (:goal (and
    (approved pr-1)
    (approved pr-2)
    (approved pr-3)
    (approved pr-4)
    (approved pr-5)
    (approved pr-6)
    (approved pr-7)
    (task-completed)))
)
