(define (problem task-3ab5b8b-2)
  (:domain appworld-3ab5b8b-2)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-liked-in-library-1 song-liked-in-library-2 song-liked-in-library-3 song-liked-in-library-4 song-liked-in-library-5 song-liked-in-library-6 - song
  )
  (:init
    (username-for spotify ch-burch-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library song-liked-in-library-1)
    (in-library song-liked-in-library-2)
    (in-library song-liked-in-library-3)
    (in-library song-liked-in-library-4)
    (in-library song-liked-in-library-5)
    (in-library song-liked-in-library-6)
    (liked song-liked-in-library-1)
    (liked song-liked-in-library-2)
    (liked song-liked-in-library-3)
    (liked song-liked-in-library-4)
    (liked song-liked-in-library-5)
    (liked song-liked-in-library-6))
  (:goal (and
    (downloaded song-liked-in-library-1)
    (downloaded song-liked-in-library-2)
    (downloaded song-liked-in-library-3)
    (downloaded song-liked-in-library-4)
    (downloaded song-liked-in-library-5)
    (downloaded song-liked-in-library-6)
    (task-completed))))
