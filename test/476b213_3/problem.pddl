(define (problem task-476b213-3)
  (:domain appworld-476b213-3)
  (:objects
    debra - person
    de-ritt-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-prime-subscription - prime-subscription
    last-prime-card - payment-card
    card-name-of-last-prime-payment - card-name
  )
  (:init
    (password-for amazon amazon-password)
    (latest-subscription last-prime-subscription)
    (paid-with last-prime-subscription last-prime-card)
  )
  (:goal (and
    (found-subscription last-prime-subscription)
    (found-card-name last-prime-card card-name-of-last-prime-payment)
    (task-completed)
  ))
)
