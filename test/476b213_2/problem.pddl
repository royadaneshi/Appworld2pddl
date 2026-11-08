(define (problem task-476b213-2)
  (:domain appworld-476b213-2)
  (:objects
    nancy-ritter - person
    nan-ritt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    last-premium-subscription - premium-subscription
    last-payment-card - payment-card
    last-card-name - card-name)
  (:init
    (password-for spotify spotify-password)
    (is-last-subscription last-premium-subscription)
    (paid-with last-premium-subscription last-payment-card)
    (card-named last-payment-card last-card-name))
  (:goal (and
    (found-card-name last-payment-card last-card-name)
    (task-completed))))
