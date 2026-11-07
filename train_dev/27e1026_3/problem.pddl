(define (problem task-27e1026-3)
  (:domain appworld-27e1026-3)
  (:objects
    brian - person
    br-ritt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    oldest-song - song
    oldest-song-title - title)
  (:init
    (username-for spotify br-ritt-at-gmail-com)
    (password-for spotify spotify-password)
    (oldest-released oldest-song))
  (:goal (and (found-title oldest-song oldest-song-title) (task-completed))))
