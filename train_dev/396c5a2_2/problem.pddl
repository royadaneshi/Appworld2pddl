(define (problem task-396c5a2-2)
  (:domain appworld-396c5a2-2)
  (:objects
    troy-solomon - person
    tr-solo-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-aria-sterling - query
    aria-sterling - artist
    playcount-990 - playcount
    aria-song-1 - song
  )
  (:init
    (email-of troy-solomon tr-solo-at-gmail-com)
    (username-for spotify tr-solo-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query query-aria-sterling aria-sterling)
    (play-count-threshold playcount-990)
    (song-by aria-song-1 aria-sterling)
    (played-over aria-song-1 playcount-990)
  )
  (:goal (and
    (in-queue aria-song-1)
    (task-completed)
  ))
)
