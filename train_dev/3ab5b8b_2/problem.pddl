(define (problem task-3ab5b8b-2)
  (:domain appworld-3ab5b8b-2)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-liked-in-library-1 song-liked-in-library-2 song-library-only song-liked-only - song)
  (:init
    (username-for spotify ch-burch-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library song-liked-in-library-1)
    (liked song-liked-in-library-1)
    (in-library song-liked-in-library-2)
    (liked song-liked-in-library-2)
    (in-library song-library-only)
    (liked song-liked-only))
  (:goal (and (downloaded song-liked-in-library-1)
              (downloaded song-liked-in-library-2)
              (task-completed))))
