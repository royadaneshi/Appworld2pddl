(define (problem task-3ab5b8b-3)
  (:domain appworld-3ab5b8b-3)
  (:objects
    erika - person
    erikabail-at-gmail-com - username
    spotify-password - password
    spotify-token - token
  )
  (:init
    (supervisor-email erikabail-at-gmail-com)
    (password-for spotify spotify-password)
    (in-album-library song-lib-liked-1)
    (in-album-library song-lib-liked-2)
    (in-album-library song-lib-liked-3)
    (in-album-library song-lib-liked-4)
    (in-album-library song-lib-liked-5)
    (in-album-library song-lib-liked-6)
    (in-album-library song-lib-liked-7)
    (in-album-library song-lib-liked-8)
    (liked-song song-lib-liked-1)
    (liked-song song-lib-liked-2)
    (liked-song song-lib-liked-3)
    (liked-song song-lib-liked-4)
    (liked-song song-lib-liked-5)
    (liked-song song-lib-liked-6)
    (liked-song song-lib-liked-7)
    (liked-song song-lib-liked-8))
  (:goal (and
    (downloaded song-lib-liked-1)
    (downloaded song-lib-liked-2)
    (downloaded song-lib-liked-3)
    (downloaded song-lib-liked-4)
    (downloaded song-lib-liked-5)
    (downloaded song-lib-liked-6)
    (downloaded song-lib-liked-7)
    (downloaded song-lib-liked-8)
    (task-completed))))
