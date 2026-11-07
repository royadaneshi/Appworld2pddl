(define (problem task-c901732-3)
  (:domain appworld-c901732-3)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-velvet-underground - query
    velvet-underground - album
    song-start other-song-1 most-played-song other-song-2 - song
  )
  (:init
    (supervisor jeremy-calhoun)
    (username-of jeremy-calhoun jer-calhoun-at-gmail-com)
    (password-for spotify spotify-password)
    (album-query query-velvet-underground velvet-underground)
    (in-album other-song-1 velvet-underground)
    (in-album most-played-song velvet-underground)
    (in-album other-song-2 velvet-underground)
    (next-song velvet-underground song-start other-song-1)
    (next-song velvet-underground other-song-1 most-played-song)
    (next-song velvet-underground most-played-song other-song-2)
    (last-song velvet-underground other-song-2)
    (checked-upto velvet-underground song-start)
    (most-played velvet-underground most-played-song)
  )
  (:goal (and (playing-most-played-song) (task-completed)))
)
