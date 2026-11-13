(define (problem task-b7a9ee9-3)
  (:domain appworld-b7a9ee9-3)
  (:objects
    ma-smith-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rock - genre
    playlist-1 playlist-2 - playlist
    indie-song-1 indie-song-2 - song
  )
  (:init
    (username-for spotify ma-smith-at-gmail-com)
    (password-for spotify spotify-password)
    (in-playlist playlist-1 indie-song-1)
    (in-playlist playlist-2 indie-song-2)
    (song-genre indie-song-1 indie)
    (song-genre indie-song-2 indie)
    (song-artist indie-song-1 indie-artist-3)
    (song-artist indie-song-1 indie-artist-1)
    (song-artist indie-song-1 indie-artist-2)
    (song-artist indie-song-2 indie-artist-1))
  (:goal (and
    (following indie-artist-1)
    (following indie-artist-2)
    (following indie-artist-3)
    (task-completed)))
)
