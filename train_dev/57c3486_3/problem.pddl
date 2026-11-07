(define (problem task-57c3486-3)
  (:domain appworld-57c3486-3)
  (:objects
    supervisor - person
    ed-wilson-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    artist-1 artist-2 - artist
    query-artist-1-name query-artist-2-name - query
    song-1-1 song-1-2 song-2-1 song-2-2 - song
    count-1 count-2 count-3 count-4 - count)
  (:init
    (supervisor-email supervisor ed-wilson-at-gmail-com)
    (password-for spotify spotify-password)
    (follows artist-1)
    (follows artist-2)
    (artist-name artist-1 query-artist-1-name)
    (artist-name artist-2 query-artist-2-name)
    (by-artist song-1-1 artist-1)
    (by-artist song-1-2 artist-1)
    (by-artist song-2-1 artist-2)
    (by-artist song-2-2 artist-2)
    (remaining count-4)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (succ count-3 count-4))
  (:goal (and
    (liked song-1-1)
    (liked song-1-2)
    (liked song-2-1)
    (liked song-2-2)
    (remaining count-0)
    (task-completed))))
