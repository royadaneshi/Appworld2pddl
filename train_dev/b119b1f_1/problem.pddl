(define (problem task-b119b1f-1)
  (:domain appworld-b119b1f-1)
  (:objects
    miranda-weber - person
    mir-powe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-luna-starlight - query
    luna-starlight other-artist - artist
    song-start song-back-1 song-back-2 song-luna - song
    q0 q1 q2 q3 - queue-pos)
  (:init
    (username-for spotify mir-powe-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query luna-starlight query-luna-starlight)
    (cursor-at q0)
    (inspected q0)
    (prev-of q0 q1)
    (prev-of q1 q2)
    (prev-of q2 q3)
    (song-at q0 song-start)
    (song-at q1 song-back-1)
    (song-at q2 song-back-2)
    (song-at q3 song-luna)
    (by-artist song-start other-artist)
    (by-artist song-back-1 other-artist)
    (by-artist song-back-2 other-artist)
    (by-artist song-luna luna-starlight))
  (:goal (and (known-id luna-starlight)
              (cursor-at q3)
              (seen-song-by q3 luna-starlight)
              (task-completed)))
)
