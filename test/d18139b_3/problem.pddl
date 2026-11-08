(define (problem task-d18139b-3)
  (:domain appworld-d18139b-3)
  (:objects
    nicholas roommate-1 roommate-2 - person
    payment-request-1 payment-request-2 payment-request-3 - payment-request
    phone-number-9503658964 nicholas-weber-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    relationship-roommate - relationship
    status-pending - status)
  (:init
    (username-for phone phone-number-9503658964)
    (username-for venmo nicholas-weber-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (roommate-relationship relationship-roommate)
    (pending-status status-pending)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (sent-by payment-request-1 roommate-1)
    (sent-by payment-request-2 roommate-1)
    (sent-by payment-request-3 roommate-2)
    (created-this-month payment-request-1)
    (created-this-month payment-request-2)
    (created-this-month payment-request-3)
    (pending payment-request-1)
    (pending payment-request-2)
    (pending payment-request-3))
  (:goal (and
    (approved payment-request-1)
    (approved payment-request-2)
    (approved payment-request-3)
    (task-completed)))
)
