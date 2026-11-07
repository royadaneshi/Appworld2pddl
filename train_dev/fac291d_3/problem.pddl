(define (problem task-fac291d-3)
  (:domain appworld-fac291d-3)
  (:objects
    jacob-blackburn - person
    jac-blackburn-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    unique-song-count - count)
  (:init
    (supervisor-username jac-blackburn-at-gmail-com)
    (password-for spotify spotify-password))
  (:goal (and
    (song-library-collected unique-song-count)
    (album-library-collected unique-song-count)
    (playlist-library-collected unique-song-count)
    (task-completed)))
)
