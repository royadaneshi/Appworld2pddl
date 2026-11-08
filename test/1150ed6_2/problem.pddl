(define (problem task-1150ed6-2)
  (:domain appworld-1150ed6-2)
  (:objects
    alexander - person
    alexander-ridd-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    album-from-library - album
    song-2021-from-library - song)
  (:init
    (password-for spotify spotify-password)
    (in-album-library album-from-library)
    (song-in-album song-2021-from-library album-from-library)
    (released-in-2021 song-2021-from-library))
  (:goal (and (playing song-2021-from-library) (task-completed)))
)
