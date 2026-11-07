(define (problem task-d4e9306-3)
  (:domain appworld-d4e9306-3)
  (:objects
    angelica - person
    angelica-wils-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 - song
    liked-album-1 - album
    artist-1 artist-2 artist-3 - artist)
  (:init
    (username-for spotify angelica-wils-at-gmail-com)
    (password-for spotify spotify-password)
    (liked-song liked-song-1)
    (liked-song liked-song-2)
    (liked-album liked-album-1)
    (song-artist liked-song-1 artist-1)
    (song-artist liked-song-2 artist-2)
    (album-artist liked-album-1 artist-3))
  (:goal (and
    (following artist-1)
    (following artist-2)
    (following artist-3)
    (task-completed)))
)
