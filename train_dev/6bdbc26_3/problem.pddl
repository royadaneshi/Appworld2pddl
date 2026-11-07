(define (problem task-6bdbc26-3)
  (:domain appworld-6bdbc26-3)
  (:objects
    grant-martinez - person
    gra-martinez-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    current-song - song
    current-artist - artist
    follower-count-answer - count
  )
  (:init
    (password-for spotify spotify-password)
    (supervisor-username gra-martinez-at-gmail-com)
    (playing current-song)
    (artist-of current-song current-artist)
    (follower-count-of current-artist follower-count-answer)
  )
  (:goal (and
    (found-follower-count current-artist follower-count-answer)
    (task-completed)
  ))
)
