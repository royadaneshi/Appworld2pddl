(define (problem task-dcb2559-1)
  (:domain appworld-dcb2559-1)
  (:objects
    joseph-weber - person
    joseph-webe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    last-premium-subscription - subscription
    same-duration - duration
    spotify-payment-card - payment-card)
  (:init
    (username-for spotify joseph-webe-at-gmail-com)
    (password-for spotify spotify-password)
    (latest-subscription last-premium-subscription)
    (subscription-duration last-premium-subscription same-duration))
  (:goal (and (subscribed-premium same-duration)
              (task-completed)))
)
