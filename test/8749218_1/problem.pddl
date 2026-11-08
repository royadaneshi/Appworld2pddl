(define (problem task-8749218-1)
  (:domain appworld-8749218-1)
  (:objects
    glen-moore - person
    gl-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
  )
  (:init
    (username-for spotify gl-moore-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended-song rec-song-1)
    (recommended-song rec-song-2)
    (recommended-song rec-song-3)
  )
  (:goal (and
    (in-queue rec-song-1)
    (in-queue rec-song-2)
    (in-queue rec-song-3)
    (queue-shuffled)
    (is-playing)
    (task-completed)
  ))
)
