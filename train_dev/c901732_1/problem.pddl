(define (problem task-c901732-1)
  (:domain appworld-c901732-1)
  (:objects
    joyce - person
    joyce-weav-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-echo-chamber-chronicles - query
    echo-chamber-chronicles - album
    least-played-song - song)
  (:init
    (supervisor-username joyce-weav-at-gmail-com)
    (password-for spotify spotify-password)
    (album-query query-echo-chamber-chronicles echo-chamber-chronicles)
    (song-in-album least-played-song echo-chamber-chronicles))
  (:goal (and (playing least-played-song) (task-completed)))
)
