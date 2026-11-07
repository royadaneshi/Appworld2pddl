(define (problem task-82e2fac-1)
  (:domain appworld-82e2fac-1)
  (:objects
    joyce-weaver - person
    joyce-weav-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    most-liked-playlist-song - song
    title-of-most-liked-song - song-title
  )
  (:init
    (supervisor-username joyce-weav-at-gmail-com)
    (password-for spotify spotify-password)
    (in-playlists most-liked-playlist-song)
    (most-liked most-liked-playlist-song)
    (title-of most-liked-playlist-song title-of-most-liked-song)
  )
  (:goal (and (found-like-count most-liked-playlist-song) (task-completed)))
)
