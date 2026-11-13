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
    (artist-matches artist-grace-harrison classical count-22)
  )
  (:goal (and
    (following artist-grace-harrison)
    (task-completed)
  ))
)
