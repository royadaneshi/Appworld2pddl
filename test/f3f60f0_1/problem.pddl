(define (problem task-f3f60f0-1)
  (:domain appworld-f3f60f0-1)
  (:objects
    cheryl-martinez - person
    cheweber-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song-1 library-song-2 library-song-3 library-song-4 library-song-5 library-song-6 library-song-7 library-song-8 library-song-9 library-song-10 library-song-11 library-song-liked-1 - song
    library-album-1 library-album-2 library-album-3 library-album-4 library-album-5 library-album-liked-1 - album
    count-1 count-2 count-3 count-4 count-5 count-6 count-7 count-8 count-9 count-10 count-11 - count
  )
  (:init
    (password-for spotify spotify-password)
    (in-song-library library-song-1)
    (in-song-library library-song-2)
    (in-song-library library-song-3)
    (in-song-library library-song-4)
    (in-song-library library-song-5)
    (in-song-library library-song-6)
    (in-song-library library-song-7)
    (in-song-library library-song-8)
    (in-song-library library-song-9)
    (in-song-library library-song-10)
    (in-song-library library-song-11)
    (in-song-library library-song-liked-1)
    (liked-song library-song-liked-1)
    (in-album-library library-album-1)
    (in-album-library library-album-2)
    (in-album-library library-album-3)
    (in-album-library library-album-4)
    (in-album-library library-album-5)
    (in-album-library library-album-liked-1)
    (liked-album library-album-liked-1)
    (unliked-library-songs count-11)
    (unliked-library-albums count-5)
    (count-pred count-1 zero)
    (count-pred count-2 count-1)
    (count-pred count-3 count-2)
    (count-pred count-4 count-3)
    (count-pred count-5 count-4)
    (count-pred count-6 count-5)
    (count-pred count-7 count-6)
    (count-pred count-8 count-7)
    (count-pred count-9 count-8)
    (count-pred count-10 count-9)
    (count-pred count-11 count-10))
  (:goal (and
    (unliked-library-songs zero)
    (unliked-library-albums zero)
    (task-completed)))
)
