(define (problem task-b119b1f-2)
  (:domain appworld-b119b1f-2)
  (:objects
    anthony-harrison - person
    an-harrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-lily-moon - query
    lily-moon other-artist - artist
    current-song-0 queued-song-1 queued-song-2 queued-song-3 lily-moon-song - song
  )
  (:init
    (supervisor anthony-harrison)
    (supervisor-username an-harrison-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query query-lily-moon lily-moon)
    (target-artist lily-moon)
    (song-by current-song-0 other-artist)
    (song-by queued-song-1 other-artist) (song-by queued-song-2 other-artist) (song-by queued-song-3 other-artist)
    (song-by lily-moon-song lily-moon)
    (queue-next current-song-0 queued-song-1)
    (queue-next queued-song-1 queued-song-2) (queue-next queued-song-2 queued-song-3) (queue-next queued-song-3 lily-moon-song)
    (cursor-at current-song-0)
    (current-song-inspected))
  (:goal (and (known-id lily-moon) (cursor-at lily-moon-song) (confirmed-song-by lily-moon-song lily-moon) (task-completed))))
