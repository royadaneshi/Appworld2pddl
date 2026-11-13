(define (problem task-e3d6c94-3)
  (:domain appworld-e3d6c94-3)
  (:objects
    caitlin-burch - person
    caiburc-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rnb-recommendation-playlist - playlist
    title-rnb-recommendation - title
    rec-song-1 rec-song-3 rec-song-2 rec-song-5 rec-song-4 rec-song-6 - song
  )
  (:init
    (supervisor caitlin-burch)
    (supervisor-username caiburc-at-gmail-com)
    (password-for spotify spotify-password)
    (playlist-title rnb-recommendation-playlist title-rnb-recommendation)
    (recommended rec-song-1)
    (recommended rec-song-3)
    (recommended rec-song-2)
    (recommended rec-song-5)
    (recommended rec-song-4)
    (recommended rec-song-6)
    (genre-rnb rec-song-1)
    (genre-rnb rec-song-3)
    (genre-rnb rec-song-2)
    (genre-rnb rec-song-4)
    (released-this-year rec-song-3)
    (released-this-year rec-song-5)
    (released-this-year rec-song-4)
    (released-this-year rec-song-6))
  (:goal (and
    (playlist-created rnb-recommendation-playlist)
    (in-playlist rnb-recommendation-playlist rec-song-3)
    (in-playlist rnb-recommendation-playlist rec-song-4)
    (task-completed)))
)
