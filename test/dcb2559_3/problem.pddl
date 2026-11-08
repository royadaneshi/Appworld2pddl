(define (problem task-dcb2559-3)
  (:domain appworld-dcb2559-3)
  (:objects
    anthony - person
    an-harrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    duration-same-as-expired - duration
    spotify-card - payment-card)
  (:init
    (password-for spotify spotify-password)
    (expired-subscription-duration duration-same-as-expired))
  (:goal (and (premium-renewed) (task-completed)))
)
