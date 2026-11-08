(define (problem task-3f3c139-1)
  (:domain appworld-3f3c139-1)
  (:objects
    erica-wilson - person
    eri-powe-at-gmail-com - username
    amazon-password spotify-password venmo-password - password
    amazon-token spotify-token venmo-token - token
    amazon-expired-card amazon-valid-card spotify-expired-card spotify-valid-card venmo-expired-card venmo-valid-card - payment-card
  )
  (:init
    (password-for amazon amazon-password)
    (password-for spotify spotify-password)
    (password-for venmo venmo-password)
    (card-of amazon amazon-expired-card)
    (card-of amazon amazon-valid-card)
    (card-of spotify spotify-expired-card)
    (card-of spotify spotify-valid-card)
    (card-of venmo venmo-expired-card)
    (card-of venmo venmo-valid-card)
    (expired amazon-expired-card)
    (expired spotify-expired-card)
    (expired venmo-expired-card)
  )
  (:goal (and
    (deleted amazon-expired-card)
    (deleted spotify-expired-card)
    (deleted venmo-expired-card)
    (task-completed)
  ))
)
