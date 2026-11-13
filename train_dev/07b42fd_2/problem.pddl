(define (problem task-07b42fd-2)
  (:domain appworld-07b42fd-2)
  (:objects
    joseph-weber - person
    joseph-webe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-edm - query
    edm - genre
    followers-23 - follower-count)
  (:init
    (username-for spotify joseph-webe-at-gmail-com)
    (password-for spotify spotify-password)
    (query-for-genre query-edm edm)
    (target-genre edm)
    (target-min-followers followers-23)
    (matches-criteria artist-jasper-skye))
  (:goal (and (following artist-jasper-skye)
              (task-completed))))
