(define (problem task-8749218-3)
  (:domain appworld-8749218-3)
  (:objects
    kayla - person
    ka-burt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rec-song-1 rec-song-2 rec-song-3 - song)
  (:init
    (password-for spotify spotify-password)
    (recommended rec-song-1)
    (recommended rec-song-2)
    (recommended rec-song-3))
  (:goal (and
    (queue-cleared)
    (in-queue rec-song-1)
    (in-queue rec-song-2)
    (in-queue rec-song-3)
    (queue-shuffled)
    (is-playing)
    (task-completed))))
