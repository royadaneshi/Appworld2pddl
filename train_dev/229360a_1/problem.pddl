(define (problem task-229360a-1)
  (:domain appworld-229360a-1)
  (:objects
    brandon-webe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-liked-1 song-downloaded-1 song-unkept-1 song-unkept-2 - song
    album-liked-1 album-downloaded-1 album-unkept-1 album-unkept-2 - album)
  (:init
    (username-for spotify brandon-webe-at-gmail-com)
    (password-for spotify spotify-password)
    (song-in-library song-liked-1)
    (song-in-library song-downloaded-1)
    (song-in-library song-unkept-1)
    (song-in-library song-unkept-2)
    (song-liked song-liked-1)
    (song-downloaded song-downloaded-1)
    (album-in-library album-liked-1)
    (album-in-library album-downloaded-1)
    (album-in-library album-unkept-1)
    (album-in-library album-unkept-2)
    (album-liked album-liked-1)
    (album-downloaded album-downloaded-1))
  (:goal (and
    (song-removed-from-library song-unkept-1)
    (song-removed-from-library song-unkept-2)
    (song-in-library song-liked-1)
    (song-in-library song-downloaded-1)
    (album-removed-from-library album-unkept-1)
    (album-removed-from-library album-unkept-2)
    (album-in-library album-liked-1)
    (album-in-library album-downloaded-1)
    (task-completed)))
)
