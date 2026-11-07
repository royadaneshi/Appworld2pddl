(define (problem task-07b42fd-1)
  (:domain appworld-07b42fd-1)
  (:objects
    erica - person
    eri-powe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-classical - query
    classical - genre
    count-22 - follower-count
  )
  (:init
    (password-for spotify spotify-password)
    (artist-matches classical-artist-1 classical count-22)
    (artist-matches classical-artist-2 classical count-22)
    (artist-matches classical-artist-3 classical count-22)
  )
  (:goal (and
    (following classical-artist-1)
    (following classical-artist-2)
    (following classical-artist-3)
    (task-completed)
  ))
)
