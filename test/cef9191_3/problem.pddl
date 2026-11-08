(define (problem task-cef9191-3)
  (:domain appworld-cef9191-3)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    most-followed-artist - artist)
  (:init
    (password-for spotify spotify-password))
  (:goal (and
    (followed-artists-listed)
    (known-follower-count most-followed-artist)
    (task-completed)))
)
