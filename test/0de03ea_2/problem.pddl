(define (problem task-0de03ea-2)
  (:domain appworld-0de03ea-2)
  (:objects
    cory - person
    corwils-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    target-playlist - playlist
    walk-30-min - duration
  )
  (:init
    (password-for spotify spotify-password)
    (in-library target-playlist)
    (walk-duration walk-30-min)
    (has-enough-downloaded target-playlist walk-30-min)
  )
  (:goal (and
    (playing-playlist target-playlist)
    (task-completed)
  ))
)
