(define (problem task-229360a-3)
  (:domain appworld-229360a-3)
  (:objects
    jose-harrison - person
    joseharr-at-gmail-com - username
    spotify-password - password
    spotify-token - token
  )
  (:init
    (username-for spotify joseharr-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library liked-song-in-library)
    (in-song-library downloaded-song-in-library)
    (in-song-library unliked-undownloaded-song)
    (liked-song liked-song-in-library)
    (downloaded-song downloaded-song-in-library)
    (in-album-library liked-album-in-library)
    (in-album-library fully-downloaded-album-in-library)
    (in-album-library unliked-undownloaded-album)
    (liked-album liked-album-in-library)
    (album-downloaded fully-downloaded-album-in-library)
  )
  (:goal (and
    (not (in-song-library unliked-undownloaded-song))
    (in-song-library liked-song-in-library)
    (in-song-library downloaded-song-in-library)
    (not (in-album-library unliked-undownloaded-album))
    (in-album-library liked-album-in-library)
    (in-album-library fully-downloaded-album-in-library)
    (task-completed)
  ))
)
