(define (problem task-57c3486-2)
  (:domain appworld-57c3486-2)
  (:objects
    jamie - person
    jamie-solomon-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    artist-1 artist-2 - artist
    query-artist-1-name query-artist-2-name - query
    song-1-1 song-1-2 song-2-1 song-2-2 - song
    n0 n1 n2 n3 n4 - count)
  (:init
    (password-for spotify spotify-password)
    (supervisor-username jamie-solomon-at-gmail-com)
    (follows artist-1)
    (follows artist-2)
    (artist-name artist-1 query-artist-1-name)
    (artist-name artist-2 query-artist-2-name)
    (song-by song-1-1 artist-1)
    (song-by song-1-2 artist-1)
    (song-by song-2-1 artist-2)
    (song-by song-2-2 artist-2)
    (like-count n0)
    (next-count n0 n1)
    (next-count n1 n2)
    (next-count n2 n3)
    (next-count n3 n4)
    (target-like-count n4))
  (:goal (and (liked song-1-1) (liked song-1-2) (liked song-2-1) (liked song-2-2) (task-completed))))
