(define (problem task-ce359b5-2)
  (:domain appworld-ce359b5-2)
  (:objects
    jeffrey-smith - person
    jefsmith-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    my-song-library - song-library
    playlist-1 - playlist
    song-released-2023 song-released-2022 song-released-2020 song-released-2019 - song
    n1 n2 n3 - count)
  (:init
    (username-for spotify jefsmith-at-gmail-com)
    (password-for spotify spotify-password)
    (contains my-song-library song-released-2023)
    (contains my-song-library song-released-2019)
    (contains playlist-1 song-released-2023)
    (contains playlist-1 song-released-2022)
    (contains playlist-1 song-released-2020)
    (released-after-2021 song-released-2023)
    (released-after-2021 song-released-2022)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (pending-removals n3))
  (:goal (and
    (not (contains my-song-library song-released-2023))
    (not (contains playlist-1 song-released-2023))
    (not (contains playlist-1 song-released-2022))
    (pending-removals n0)
    (task-completed)))
)
