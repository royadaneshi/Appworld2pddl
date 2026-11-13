(define (problem task-3ab5b8b-2)
  (:domain appworld-3ab5b8b-2)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-9 song-28 song-87 song-110 song-151 song-199 - song
  )
  (:init
    (username-for spotify ch-burch-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library song-9)
    (in-library song-28)
    (in-library song-87)
    (in-library song-110)
    (in-library song-151)
    (in-library song-199)
    (liked song-9)
    (liked song-28)
    (liked song-87)
    (liked song-110)
    (liked song-151)
    (liked song-199))
  (:goal (and
    (downloaded song-9)
    (downloaded song-28)
    (downloaded song-87)
    (downloaded song-110)
    (downloaded song-151)
    (downloaded song-199)
    (task-completed))))
