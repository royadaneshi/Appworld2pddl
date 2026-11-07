(define (problem task-d4e9306-2)
  (:domain appworld-d4e9306-2)
  (:objects
    alex-white - person
    alexwhite-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 - song
    liked-album-1 liked-album-2 - album)
  (:init
    (supervisor-username alexwhite-at-gmail-com)
    (password-for spotify spotify-password)
    (liked-song liked-song-1)
    (liked-song liked-song-2)
    (liked-album liked-album-1)
    (liked-album liked-album-2)
    (song-artist liked-song-1 artist-1)
    (song-artist liked-song-2 artist-2)
    (album-artist liked-album-1 artist-3)
    (album-artist liked-album-2 artist-4))
  (:goal (and
    (following artist-1)
    (following artist-2)
    (following artist-3)
    (following artist-4)
    (task-completed))))
