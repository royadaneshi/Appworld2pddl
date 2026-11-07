(define (problem task-b7a9ee9-3)
  (:domain appworld-b7a9ee9-3)
  (:objects
    ma-smith-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    indie-song-1 rock-song-1 indie-song-2 - song
    rock-artist-1 - artist
    rock - genre)
  (:init
    (username-for spotify ma-smith-at-gmail-com)
    (password-for spotify spotify-password)
    (in-playlist playlist-1 indie-song-1)
    (in-playlist playlist-1 rock-song-1)
    (in-playlist playlist-2 indie-song-2)
    (song-genre indie-song-1 indie)
    (song-genre rock-song-1 rock)
    (song-genre indie-song-2 indie)
    (song-artist indie-song-1 indie-artist-1)
    (song-artist rock-song-1 rock-artist-1)
    (song-artist indie-song-2 indie-artist-2)
    (song-artist indie-song-2 indie-artist-1))
  (:goal (and
    (following indie-artist-1)
    (following indie-artist-2)
    (task-completed)))
)
