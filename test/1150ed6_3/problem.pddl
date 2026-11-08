(define (problem task-1150ed6-3)
  (:domain appworld-1150ed6-3)
  (:objects
    jonathan-ball - person
    jo-ball-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    my-playlist-1 my-playlist-2 - playlist
    song-released-2020 song-released-2019 song-released-2021 - song
    year-2019 year-2021 - year)
  (:init
    (password-for spotify spotify-password)
    (in-library my-playlist-1)
    (in-library my-playlist-2)
    (in-playlist song-released-2020 my-playlist-1)
    (in-playlist song-released-2019 my-playlist-1)
    (in-playlist song-released-2021 my-playlist-2)
    (released-in song-released-2020 year-2020)
    (released-in song-released-2019 year-2019)
    (released-in song-released-2021 year-2021))
  (:goal (and (playing-song-of-year year-2020) (task-completed))))
