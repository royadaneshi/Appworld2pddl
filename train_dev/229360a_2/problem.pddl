(define (problem task-229360a-2)
  (:domain appworld-229360a-2)
  (:objects
    jepowell-at-gmail-com - username
    spotify-password - password
    spotify-token - token
  )
  (:init
    (supervisor-username jepowell-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library song-liked-downloaded)
    (in-song-library song-liked-not-downloaded)
    (in-song-library song-downloaded-not-liked)
    (in-song-library song-not-liked-not-downloaded)
    (song-liked-and-downloaded song-liked-downloaded)
    (in-album-library album-liked-all-downloaded)
    (in-album-library album-liked-partly-downloaded)
    (in-album-library album-not-liked)
    (album-liked-and-downloaded album-liked-all-downloaded)
  )
  (:goal (and
    (in-song-library song-liked-downloaded)
    (not (in-song-library song-liked-not-downloaded))
    (not (in-song-library song-downloaded-not-liked))
    (not (in-song-library song-not-liked-not-downloaded))
    (in-album-library album-liked-all-downloaded)
    (not (in-album-library album-liked-partly-downloaded))
    (not (in-album-library album-not-liked))
    (task-completed)
  ))
)
