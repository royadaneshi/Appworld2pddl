(define (problem task-b119b1f-3)
  (:domain appworld-b119b1f-3)
  (:objects
    sherry - person
    she-bailey-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-silent-thunder - query
    silent-thunder other-artist - artist
    song-current song-prev-1 song-silent-thunder-1 song-silent-thunder-2 song-silent-thunder - song
    pos-current pos-prev-1 pos-prev-2 position-1 position-2 - position
  )
  (:init
    (supervisor sherry)
    (supervisor-username she-bailey-at-gmail-com)
    (password-for spotify spotify-password)
    (artist-query silent-thunder query-silent-thunder)
    (target-artist silent-thunder)
    (cursor-at pos-current)
    (may-go-previous)
    (prev-position pos-current pos-prev-1)
    (prev-position pos-prev-1 pos-prev-2) (prev-position pos-prev-2 position-1) (prev-position position-1 position-2)
    (song-at pos-current song-current)
    (song-at pos-prev-1 song-prev-1)
    (song-at pos-prev-2 song-silent-thunder-1) (song-at position-1 song-silent-thunder-2) (song-at position-2 song-silent-thunder)
    (by-artist song-current other-artist)
    (by-artist song-prev-1 other-artist) (by-artist song-silent-thunder-1 other-artist) (by-artist song-silent-thunder-2 other-artist)
    (by-artist song-silent-thunder silent-thunder))
  (:goal (and
    (cursor-at position-2)
    (checked song-silent-thunder silent-thunder)
    (task-completed)))
)
