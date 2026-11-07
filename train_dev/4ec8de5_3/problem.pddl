(define (problem task-4ec8de5-3)
  (:domain appworld-4ec8de5-3)
  (:objects
    chad-brown - person
    ch-brow-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song - song
    library-album - album
    count-songs-before-this-year - count)
  (:init
    (supervisor-username ch-brow-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library library-song)
    (in-album-library library-album))
  (:goal (and (current-date-known)
              (song-library-listed)
              (album-library-listed)
              (known-release-date library-song)
              (known-album-release-date library-album)
              (known-album-songs library-album)
              (task-completed)))
)
