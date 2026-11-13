(define (problem task-ccf4b82-2)
  (:domain appworld-ccf4b82-2)
  (:objects
    timothy - person
    timothy-whit-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    status-pending - status
    req-1 req-2 req-3 req-4 req-5 req-6 req-7 req-8 req-9 req-10 req-11 req-12 req-13 req-14 req-15 req-old - payment-request
    remaining-balance - amount
    card-1102 - card
  )
  (:init
    (password-for venmo venmo-password)
    (pending-status status-pending)
    (pending-in-window req-1)
    (pending-in-window req-2)
    (pending-in-window req-3)
    (pending-in-window req-4)
    (pending-in-window req-5)
    (pending-in-window req-6)
    (pending-in-window req-7)
    (pending-in-window req-8)
    (pending-in-window req-9)
    (pending-in-window req-10)
    (pending-in-window req-11)
    (pending-in-window req-12)
    (pending-in-window req-13)
    (pending-in-window req-14)
    (pending-in-window req-15)
    (target-card card-1102))
  (:goal (and
    (approved req-1)
    (approved req-2)
    (approved req-3)
    (approved req-4)
    (approved req-5)
    (approved req-6)
    (approved req-7)
    (approved req-8)
    (approved req-9)
    (approved req-10)
    (approved req-11)
    (approved req-12)
    (approved req-13)
    (approved req-14)
    (approved req-15)
    (withdrawn remaining-balance card-1102)
    (balance-settled)
    (task-completed))))
