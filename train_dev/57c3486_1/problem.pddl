(define (problem task-57c3486-1)
  (:domain appworld-57c3486-1)
  (:objects
    jason - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    artist-1 artist-2 - artist
    query-artist-1-name query-artist-2-name - query
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (followed artist-1)
    (followed artist-2)
    (artist-name artist-1 query-artist-1-name)
    (artist-name artist-2 query-artist-2-name)
    (song-by song-1-1 artist-1)
    (song-by song-1-2 artist-1)
    (song-by song-2-1 artist-2)
    (song-by song-2-2 artist-2)
  )
  (:goal (and
    (liked song-1-1)
    (liked song-1-2)
    (liked song-2-1)
    (liked song-2-2)
    (task-completed)
  ))
)
