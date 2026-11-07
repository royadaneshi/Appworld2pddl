(define (problem task-396c5a2-1)
  (:domain appworld-396c5a2-1)
  (:objects
    susan - person
    susanmiller-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-lily-moon - query
    lily-moon - artist
    playcount-980 - playcount)
  (:init
    (supervisor-username susanmiller-at-gmail-com)
    (password-for spotify spotify-password)
    (query-for query-lily-moon lily-moon)
    (play-count-threshold playcount-980)
    (song-by lily-moon-song-1 lily-moon)
    (song-by lily-moon-song-2 lily-moon)
    (song-by lily-moon-song-3 lily-moon)
    (play-count-over lily-moon-song-1 playcount-980)
    (play-count-over lily-moon-song-2 playcount-980)
    (play-count-over lily-moon-song-3 playcount-980))
  (:goal (and
    (in-queue lily-moon-song-1)
    (in-queue lily-moon-song-2)
    (in-queue lily-moon-song-3)
    (task-completed)))
)
