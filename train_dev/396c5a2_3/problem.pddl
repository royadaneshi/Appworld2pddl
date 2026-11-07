(define (problem task-396c5a2-3)
  (:domain appworld-396c5a2-3)
  (:objects
    leslie-ball - person
    les-ball-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-astrid-nightshade - query
    astrid-nightshade - artist
    play-count-980 - play-count
    astrid-high-play-song - song)
  (:init
    (supervisor-username les-ball-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query query-astrid-nightshade astrid-nightshade)
    (qualifies astrid-high-play-song astrid-nightshade play-count-980))
  (:goal (and (queued astrid-high-play-song) (task-completed)))
)
