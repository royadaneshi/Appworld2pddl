(define (problem task-b7a9ee9-1)
  (:domain appworld-b7a9ee9-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    pop - genre
    playlist-1 playlist-2 playlist-3 playlist-4 playlist-5 playlist-6 playlist-7 - playlist
    song-1 song-2 song-3 song-4 song-5 song-6 song-7 - song
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (owns-playlist playlist-1)
    (owns-playlist playlist-2)
    (owns-playlist playlist-3)
    (owns-playlist playlist-4)
    (owns-playlist playlist-5)
    (owns-playlist playlist-6)
    (owns-playlist playlist-7)
    (contains playlist-1 song-5)
    (contains playlist-2 song-6)
    (contains playlist-3 song-2)
    (contains playlist-3 song-7)
    (contains playlist-4 song-3)
    (contains playlist-4 song-5)
    (contains playlist-5 song-1)
    (contains playlist-6 song-4)
    (contains playlist-6 song-6)
    (contains playlist-7 song-1)
    (song-genre song-1 classical)
    (song-genre song-2 classical)
    (song-genre song-3 classical)
    (song-genre song-4 classical)
    (song-genre song-5 classical)
    (song-genre song-6 classical)
    (song-genre song-7 classical)
    (song-artist song-1 classical-artist-5)
    (song-artist song-2 classical-artist-1)
    (song-artist song-3 classical-artist-2)
    (song-artist song-4 classical-artist-2)
    (song-artist song-5 classical-artist-3)
    (song-artist song-6 classical-artist-4)
    (song-artist song-7 classical-artist-4))
  (:goal (and
    (following classical-artist-1)
    (following classical-artist-2)
    (following classical-artist-3)
    (following classical-artist-4)
    (following classical-artist-5)
    (task-completed)))
)
