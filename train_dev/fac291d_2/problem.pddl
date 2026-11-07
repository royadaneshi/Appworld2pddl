(define (problem task-fac291d-2)
  (:domain appworld-fac291d-2)
  (:objects
    deniseburch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    unique-song-count-value - count)
  (:init
    (supervisor-username deniseburch-at-gmail-com)
    (password-for spotify spotify-password)
    (unique-song-count unique-song-count-value))
  (:goal (and
    (found-song-library)
    (found-album-library)
    (found-playlist-library)
    (answered unique-song-count-value)
    (task-completed)))
)
