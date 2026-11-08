(define (problem task-ccf4b82-2)
  (:domain appworld-ccf4b82-2)
  (:objects
    timothy - person
    timothy-whit-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    status-pending - status
    req-1 req-2 req-old - payment-request
    remaining-balance - amount
    card-1102 - card)
  (:init
    (password-for venmo venmo-password)
    (pending-status status-pending)
    (pending-in-window req-1)
    (pending-in-window req-2)
    (target-card card-1102))
  (:goal (and
    (approved req-1)
    (approved req-2)
    (withdrawn remaining-balance card-1102)
    (balance-settled)
    (task-completed))))
