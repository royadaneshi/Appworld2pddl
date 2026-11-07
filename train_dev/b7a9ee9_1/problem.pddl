(define (problem task-b7a9ee9-1)
  (:domain appworld-b7a9ee9-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1 song-2 song-3 - song
    pop-artist-1 - artist
    pop - genre
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (owns-playlist playlist-1)
    (owns-playlist playlist-2)
    (contains playlist-1 song-1)
    (contains playlist-1 song-2)
    (contains playlist-2 song-3)
    (song-genre song-1 classical)
    (song-genre song-2 pop)
    (song-genre song-3 classical)
    (song-artist song-1 classical-artist-1)
    (song-artist song-2 pop-artist-1)
    (song-artist song-3 classical-artist-1)
    (song-artist song-3 classical-artist-2)
  )
  (:goal (and
    (following classical-artist-1)
    (following classical-artist-2)
    (task-completed)
  ))
)
