(define (problem task-f3f60f0-3)
  (:domain appworld-f3f60f0-3)
  (:objects
    caitlin - person
    caiburc-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-1 song-2 song-3 - song
    album-1 album-2 album-3 - album
  )
  (:init
    (password-for spotify spotify-password)
    ; song library: song-1 and song-2 not yet liked, song-3 already liked
    (in-song-library song-1)
    (in-song-library song-2)
    (in-song-library song-3)
    (liked-song song-3)
    ; album library: album-1 and album-2 not yet liked, album-3 already liked
    (in-album-library album-1)
    (in-album-library album-2)
    (in-album-library album-3)
    (liked-album album-3)
  )
  (:goal (and
    (liked-song song-1)
    (liked-song song-2)
    (liked-song song-3)
    (liked-album album-1)
    (liked-album album-2)
    (liked-album album-3)
    (task-completed)
  ))
)
