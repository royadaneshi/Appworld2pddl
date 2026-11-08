(define (problem task-ba46d91-1)
  (:domain appworld-ba46d91-1)
  (:objects
    caitlin - person
    caiburc-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    premium-subscription - subscription
    days-remaining - day-count
  )
  (:init
    (password-for spotify spotify-password)
    (subscriber caitlin premium-subscription)
  )
  (:goal (and
    (found-days-left days-remaining premium-subscription)
    (task-completed)
  ))
)
