(define (problem task-f3f60f0-1)
  (:domain appworld-f3f60f0-1)
  (:objects
    cheryl-martinez - person
    cheweber-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song-1 library-song-2 library-song-3 - song
    library-album-1 library-album-2 - album
    count-1 count-2 - count)
  (:init
    (password-for spotify spotify-password)
    (in-song-library library-song-1)
    (in-song-library library-song-2)
    (in-song-library library-song-3)
    (liked-song library-song-3)
    (in-album-library library-album-1)
    (in-album-library library-album-2)
    (liked-album library-album-2)
    (unliked-library-songs count-2)
    (unliked-library-albums count-1)
    (count-pred count-2 count-1)
    (count-pred count-1 zero))
  (:goal (and
    (unliked-library-songs zero)
    (unliked-library-albums zero)
    (task-completed)))
)
