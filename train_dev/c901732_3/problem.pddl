(define (problem task-c901732-3)
  (:domain appworld-c901732-3)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-velvet-underground - query
    velvet-underground - album
    song-start song-37 song-38 song-39 song-40 song-41 song-42 song-43 - song
  )
  (:init
    (supervisor jeremy-calhoun)
    (username-of jeremy-calhoun jer-calhoun-at-gmail-com)
    (password-for spotify spotify-password)
    (album-query query-velvet-underground velvet-underground)
    (checked-upto velvet-underground song-start)
    (in-album song-37 velvet-underground)
    (in-album song-38 velvet-underground)
    (in-album song-39 velvet-underground)
    (in-album song-40 velvet-underground)
    (in-album song-41 velvet-underground)
    (in-album song-42 velvet-underground)
    (in-album song-43 velvet-underground)
    (next-song velvet-underground song-start song-37)
    (next-song velvet-underground song-37 song-38)
    (next-song velvet-underground song-38 song-39)
    (next-song velvet-underground song-39 song-40)
    (next-song velvet-underground song-40 song-41)
    (next-song velvet-underground song-41 song-42)
    (next-song velvet-underground song-42 song-43)
    (last-song velvet-underground song-43)
    (most-played velvet-underground song-41))
  (:goal (and (playing-most-played-song) (task-completed)))
)
