(define (problem task-82e2fac-3)
  (:domain appworld-82e2fac-3)
  (:objects
    paul-miller - person
    paul-mill-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    most-played-song - song
    most-played-song-title - song-title)
  (:init
    (supervisor paul-miller)
    (username-for spotify paul-mill-at-gmail-com)
    (password-for spotify spotify-password))
  (:goal (and
    (in-album-library most-played-song)
    (found-play-count most-played-song)
    (found-title most-played-song most-played-song-title)
    (task-completed)))
)
