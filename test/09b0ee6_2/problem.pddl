(define (problem task-09b0ee6-2)
  (:domain appworld-09b0ee6-2)
  (:objects
    tammy - person
    ta-weav-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    my-playlist - playlist
    playlist-song - song
    least-4-artists - artist-list
  )
  (:init
    (password-for spotify spotify-password)
    (in-library my-playlist)
    (contains my-playlist playlist-song)
    (tallies least-4-artists playlist-song)
  )
  (:goal (and
    (found least-4-artists)
    (task-completed)
  ))
)
