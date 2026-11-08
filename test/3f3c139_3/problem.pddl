(define (problem task-3f3c139-3)
  (:domain appworld-3f3c139-3)
  (:objects
    chris-mccoy - person
    chris-mcco-at-gmail-com - username
    amazon-password spotify-password venmo-password - password
    amazon-token spotify-token venmo-token - token
    amazon-expired-card-1 amazon-expired-card-2 amazon-valid-card-1
    spotify-expired-card-1 spotify-valid-card-1
    venmo-expired-card-1 venmo-valid-card-1 - card
  )
  (:init
    (account-username amazon chris-mcco-at-gmail-com)
    (account-username spotify chris-mcco-at-gmail-com)
    (account-username venmo chris-mcco-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for spotify spotify-password)
    (password-for venmo venmo-password)
    (token-for amazon amazon-token)
    (token-for spotify spotify-token)
    (token-for venmo venmo-token)
    (card-of amazon-expired-card-1 amazon)
    (card-of amazon-expired-card-2 amazon)
    (card-of amazon-valid-card-1 amazon)
    (card-of spotify-expired-card-1 spotify)
    (card-of spotify-valid-card-1 spotify)
    (card-of venmo-expired-card-1 venmo)
    (card-of venmo-valid-card-1 venmo)
    (expired amazon-expired-card-1)
    (expired amazon-expired-card-2)
    (expired spotify-expired-card-1)
    (expired venmo-expired-card-1)
  )
  (:goal (and
    (card-deleted amazon-expired-card-1)
    (card-deleted amazon-expired-card-2)
    (card-deleted spotify-expired-card-1)
    (card-deleted venmo-expired-card-1)
    (task-completed)
  ))
)
