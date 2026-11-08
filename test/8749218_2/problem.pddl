(define (problem task-8749218-2)
  (:domain appworld-8749218-2)
  (:objects
    susan - person
    susanmiller-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rec-song-1 rec-song-2 rec-song-3 - song
  )
  (:init
    (username-for spotify susanmiller-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended rec-song-1)
    (recommended rec-song-2)
    (recommended rec-song-3)
  )
  (:goal (and
    (queue-reset)
    (in-queue rec-song-1)
    (in-queue rec-song-2)
    (in-queue rec-song-3)
    (queue-shuffled)
    (music-playing)
    (task-completed)
  ))
)
