(define (problem task-fac291d-1)
  (:domain appworld-fac291d-1)
  (:objects
    debra - person
    de-ritt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    unique-song-count - count)
  (:init
    (username-for spotify de-ritt-at-gmail-com)
    (password-for spotify spotify-password))
  (:goal (and (song-library-seen)
              (album-library-seen)
              (playlist-library-seen)
              (task-completed)))
)
