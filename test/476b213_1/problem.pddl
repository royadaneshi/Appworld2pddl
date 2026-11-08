(define (problem task-476b213-1)
  (:domain appworld-476b213-1)
  (:objects
    christina - person
    chrharrison-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-prime-subscription - prime-subscription
    last-prime-card - payment-card
    last-prime-card-name - card-name)
  (:init
    (password-for amazon amazon-password)
    (last-subscription last-prime-subscription)
    (paid-with last-prime-subscription last-prime-card)
    (card-named last-prime-card last-prime-card-name))
  (:goal (and (answer-known last-prime-card-name)
              (task-completed)))
)
