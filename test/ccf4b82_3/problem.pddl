(define (problem task-ccf4b82-3)
  (:domain appworld-ccf4b82-3)
  (:objects
    cory - person
    corwils-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    status-pending - status
    pr-may-1 pr-may-2 pr-apr-pending - payment-request
    card-ending-4184 - payment-card
    amount-remaining-balance - amount)
  (:init
    (password-for venmo venmo-password)
    (pending pr-may-1)
    (pending pr-may-2)
    (pending pr-apr-pending)
    (received-this-month pr-may-1)
    (received-this-month pr-may-2)
    (remaining-balance amount-remaining-balance))
  (:goal (and
    (approved pr-may-1)
    (approved pr-may-2)
    (not (approved pr-apr-pending))
    (balance-withdrawn)
    (withdrawn-to card-ending-4184)
    (task-completed)))
)
