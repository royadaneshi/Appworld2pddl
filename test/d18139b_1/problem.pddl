(define (problem task-d18139b-1)
  (:domain appworld-d18139b-1)
  (:objects
    jose-harrison roommate-1 roommate-2 non-roommate-1 - person
    pr-1 pr-2 pr-3 pr-4 pr-5 - payment-request
    phone-username venmo-username - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    relationship-roommate - relationship
    status-pending - status)
  (:init
    (username-for phone phone-username)
    (username-for venmo venmo-username)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate roommate-1)
    (roommate roommate-2)
    (request-from pr-1 roommate-1)
    (request-from pr-2 roommate-1)
    (request-from pr-3 roommate-2)
    (request-from pr-4 roommate-2)
    (request-from pr-5 non-roommate-1)
    (request-this-month pr-1)
    (request-this-month pr-2)
    (request-this-month pr-3)
    (request-this-month pr-5)
    (request-pending pr-1)
    (request-pending pr-2)
    (request-pending pr-3)
    (request-pending pr-4)
    (request-pending pr-5))
  (:goal (and (approved pr-1) (approved pr-2) (approved pr-3) (task-completed)))
)
