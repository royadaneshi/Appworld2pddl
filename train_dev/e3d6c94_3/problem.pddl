(define (problem task-e3d6c94-3)
  (:domain appworld-e3d6c94-3)
  (:objects
    caitlin-burch - person
    caiburc-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rec-song-1 rec-song-2 rec-song-3 rec-song-4 - song
    rnb-recommendation-playlist - playlist
    title-rnb-recommendation - title
  )
  (:init
    (supervisor caitlin-burch)
    (supervisor-username caiburc-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended rec-song-1)
    (recommended rec-song-2)
    (recommended rec-song-3)
    (recommended rec-song-4)
    (genre-rnb rec-song-1)
    (released-this-year rec-song-1)
    (genre-rnb rec-song-2)
    (released-this-year rec-song-2)
    (released-this-year rec-song-3)
    (genre-rnb rec-song-4)
    (playlist-title rnb-recommendation-playlist title-rnb-recommendation)
  )
  (:goal (and
    (playlist-created rnb-recommendation-playlist)
    (in-playlist rnb-recommendation-playlist rec-song-1)
    (in-playlist rnb-recommendation-playlist rec-song-2)
    (task-completed)
  ))
)
