(define (problem task-f3f60f0-2)
  (:domain appworld-f3f60f0-2)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-1 song-2 song-3 - song
    album-1 album-2 - album
  )
  (:init
    (password-for spotify spotify-password)
    (in-song-library song-1)
    (in-song-library song-2)
    (in-song-library song-3)
    (liked-song song-1)
    (in-album-library album-1)
    (in-album-library album-2)
    (liked-album album-1)
  )
  (:goal (and
    (song-library-known)
    (liked-songs-known)
    (album-library-known)
    (liked-albums-known)
    (liked-song song-1)
    (liked-song song-2)
    (liked-song song-3)
    (liked-album album-1)
    (liked-album album-2)
    (task-completed)
  ))
)
