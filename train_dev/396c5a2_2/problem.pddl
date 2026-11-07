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
    aria-song-1 aria-song-2 aria-song-3 - song
  )
  (:init
    (email-of troy-solomon tr-solo-at-gmail-com)
    (username-for spotify tr-solo-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query query-aria-sterling aria-sterling)
    (play-count-threshold playcount-990)
    (song-by aria-song-1 aria-sterling)
    (song-by aria-song-2 aria-sterling)
    (song-by aria-song-3 aria-sterling)
    (played-over aria-song-1 playcount-990)
    (played-over aria-song-2 playcount-990)
    (played-over aria-song-3 playcount-990)
  )
  (:goal (and
    (in-queue aria-song-1)
    (in-queue aria-song-2)
    (in-queue aria-song-3)
    (task-completed)
  ))
)
