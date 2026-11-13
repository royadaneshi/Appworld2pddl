(define (problem task-e3d6c94-3)
  (:domain appworld-e3d6c94-3)
  (:objects
    caitlin-burch - person
    caiburc-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rnb-recommendation-playlist - playlist
    title-rnb-recommendation - title
    song-12 song-87 song-88 song-174 song-184 song-273 - song
  )
  (:init
    (supervisor caitlin-burch)
    (supervisor-username caiburc-at-gmail-com)
    (password-for spotify spotify-password)
    (playlist-title rnb-recommendation-playlist title-rnb-recommendation)
    (recommended song-12)
    (recommended song-87)
    (recommended song-88)
    (recommended song-174)
    (recommended song-184)
    (recommended song-273)
    (genre-rnb song-12)
    (genre-rnb song-87)
    (genre-rnb song-88)
    (genre-rnb song-184)
    (released-this-year song-87)
    (released-this-year song-174)
    (released-this-year song-184)
    (released-this-year song-273))
  (:goal (and
    (playlist-created rnb-recommendation-playlist)
    (in-playlist rnb-recommendation-playlist song-87)
    (in-playlist rnb-recommendation-playlist song-184)
    (task-completed)))
)
