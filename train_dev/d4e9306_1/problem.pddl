(define (problem task-d4e9306-1)
  (:domain appworld-d4e9306-1)
  (:objects
    aaron-burton - person
    aa-burt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 - song
    liked-album-1 liked-album-2 - album
    artist-of-song-1 artist-of-song-2 artist-of-album-1 artist-of-album-2 - artist
  )
  (:init
    (username-for spotify aa-burt-at-gmail-com)
    (password-for spotify spotify-password)
    (liked-song liked-song-1)
    (liked-song liked-song-2)
    (liked-album liked-album-1)
    (liked-album liked-album-2)
    (artist-of-song liked-song-1 artist-of-song-1)
    (artist-of-song liked-song-2 artist-of-song-2)
    (artist-of-album liked-album-1 artist-of-album-1)
    (artist-of-album liked-album-2 artist-of-album-2)
  )
  (:goal (and
    (following artist-of-song-1)
    (following artist-of-song-2)
    (following artist-of-album-1)
    (following artist-of-album-2)
    (task-completed)
  ))
)
