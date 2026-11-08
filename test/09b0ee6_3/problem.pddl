(define (problem task-09b0ee6-3)
  (:domain appworld-09b0ee6-3)
  (:objects
    ashlee-martinez-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    my-playlist - playlist
    playlist-song - song
    top-3-artists - answer)
  (:init
    (password-for spotify spotify-password)
    (in-library my-playlist)
    (song-in-playlist playlist-song my-playlist))
  (:goal (and
    (found-top-artists top-3-artists)
    (task-completed)))
)
