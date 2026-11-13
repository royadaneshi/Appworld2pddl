(define (problem task-c901732-3)
  (:domain appworld-c901732-3)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-velvet-underground - query
    velvet-underground - album
    song-start other-song-1 other-song-2 other-song-3 other-song-4 most-played-song other-song-5 other-song-6 - song
  )
  (:init
    (supervisor jeremy-calhoun)
    (username-of jeremy-calhoun jer-calhoun-at-gmail-com)
    (password-for spotify spotify-password)
    (album-query query-velvet-underground velvet-underground)
    (checked-upto velvet-underground song-start)
    (in-album other-song-1 velvet-underground)
    (in-album other-song-2 velvet-underground)
    (in-album other-song-3 velvet-underground)
    (in-album other-song-4 velvet-underground)
    (in-album most-played-song velvet-underground)
    (in-album other-song-5 velvet-underground)
    (in-album other-song-6 velvet-underground)
    (next-song velvet-underground song-start other-song-1)
    (next-song velvet-underground other-song-1 other-song-2)
    (next-song velvet-underground other-song-2 other-song-3)
    (next-song velvet-underground other-song-3 other-song-4)
    (next-song velvet-underground other-song-4 most-played-song)
    (next-song velvet-underground most-played-song other-song-5)
    (next-song velvet-underground other-song-5 other-song-6)
    (last-song velvet-underground other-song-6)
    (most-played velvet-underground most-played-song))
  (:goal (and (playing-most-played-song) (task-completed)))
)
