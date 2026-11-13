(define (problem task-b7a9ee9-3)
  (:domain appworld-b7a9ee9-3)
  (:objects
    ma-smith-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rock - genre
    playlist-398 playlist-395 - playlist
    song-32 song-202 - song
  )
  (:init
    (username-for spotify ma-smith-at-gmail-com)
    (password-for spotify spotify-password)
    (in-playlist playlist-398 song-32)
    (in-playlist playlist-395 song-202)
    (song-genre song-32 indie)
    (song-genre song-202 indie)
    (song-artist song-32 artist-noah-bennett)
    (song-artist song-32 artist-ethan-wallace)
    (song-artist song-32 artist-nova-harmony)
    (song-artist song-202 artist-ethan-wallace))
  (:goal (and
    (following artist-ethan-wallace)
    (following artist-nova-harmony)
    (following artist-noah-bennett)
    (task-completed)))
)
