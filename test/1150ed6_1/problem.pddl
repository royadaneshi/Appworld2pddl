(define (problem task-1150ed6-1)
  (:domain appworld-1150ed6-1)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-released-2022 - song
    year-2022 - year)
  (:init
    (password-for spotify spotify-password)
    (in-library song-released-2022)
    (released-in song-released-2022 year-2022)
    (target-year year-2022))
  (:goal (and (target-song-playing) (task-completed))))
