(define (problem task-cef9191-2)
  (:domain appworld-cef9191-2)
  (:objects
    brian - person
    br-ritt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    least-followed-artist - artist
  )
  (:init
    (username-for spotify br-ritt-at-gmail-com)
    (password-for spotify spotify-password)
  )
  (:goal (and
    (found-least-followed least-followed-artist)
    (task-completed)
  ))
)
