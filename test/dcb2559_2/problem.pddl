(define (problem task-dcb2559-2)
  (:domain appworld-dcb2559-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    expired-prime-subscription - subscription
    same-duration - duration
    amazon-payment-card - payment-card)
  (:init
    (password-for amazon amazon-password)
    (last-subscription expired-prime-subscription)
    (subscription-duration expired-prime-subscription same-duration))
  (:goal (and (prime-renewed) (task-completed))))
