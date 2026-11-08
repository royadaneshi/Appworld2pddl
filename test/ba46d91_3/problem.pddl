(define (problem task-ba46d91-3)
  (:domain appworld-ba46d91-3)
  (:objects
    kyle-moore - person
    kyl-moor-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    premium-subscription - subscription
    months-left - months)
  (:init
    (password-for spotify spotify-password))
  (:goal (and (found-months-left months-left)
              (task-completed)))
)
