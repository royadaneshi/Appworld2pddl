(define (problem task-0de03ea-1)
  (:domain appworld-0de03ea-1)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    target-album - album
    minutes-15 - duration
  )
  (:init
    (username-for spotify as-moore-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library target-album)
    (drive-duration minutes-15)
    (downloads-sufficient target-album minutes-15)
  )
  (:goal (and
    (playing target-album)
    (queue-is-album target-album)
    (task-completed)
  ))
)
