(define (problem task-cef9191-1)
  (:domain appworld-cef9191-1)
  (:objects
    valerie - person
    va-blac-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    most-followed-artist - artist)
  (:init
    (password-for spotify spotify-password))
  (:goal (and (following-listed) (found-most-followed most-followed-artist) (task-completed))))
