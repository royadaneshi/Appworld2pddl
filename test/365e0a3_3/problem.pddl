(define (problem task-365e0a3-3)
  (:domain appworld-365e0a3-3)
  (:objects
    kevin-blac-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    page-limit-20 - page-limit
    prime-total-amount - amount)
  (:init
    (password-for amazon amazon-password))
  (:goal (and (found-prime-total prime-total-amount) (task-completed))))
