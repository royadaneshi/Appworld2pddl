(define (problem task-ba46d91-2)
  (:domain appworld-ba46d91-2)
  (:objects
    kevin - person
    kevin-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    active-prime-subscription - subscription
    months-left - months)
  (:init
    (username-for amazon kevin-blac-at-gmail-com)
    (password-for amazon amazon-password)
    (prime-subscription-of kevin active-prime-subscription)
    (months-remaining active-prime-subscription months-left))
  (:goal (and (found-months-left months-left)
              (task-completed))))
