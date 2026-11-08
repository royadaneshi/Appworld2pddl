(define (problem task-ccf4b82-1)
  (:domain appworld-ccf4b82-1)
  (:objects
    troy-solomon - person
    tr-solo-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    status-pending - status
    request-this-month-1 request-this-month-2 request-from-april - payment-request
    card-ending-8907 - payment-card
    amount-remaining-balance - amount)
  (:init
    (password-for venmo venmo-password)
    (is-pending-status status-pending)
    (pending request-this-month-1)
    (pending request-this-month-2)
    (pending request-from-april)
    (received-this-month request-this-month-1)
    (received-this-month request-this-month-2)
    (target-card card-ending-8907))
  (:goal (and
    (approved request-this-month-1)
    (approved request-this-month-2)
    (withdrawn-to card-ending-8907)
    (balance-zero)
    (task-completed)))
)
