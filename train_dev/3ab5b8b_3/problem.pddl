(define (problem task-3ab5b8b-3)
  (:domain appworld-3ab5b8b-3)
  (:objects
    erika - person
    erikabail-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-lib-only song-liked-only - song)
  (:init
    (supervisor-email erikabail-at-gmail-com)
    (password-for spotify spotify-password)
    (in-album-library song-lib-liked-1)
    (in-album-library song-lib-liked-2)
    (in-album-library song-lib-only)
    (liked-song song-lib-liked-1)
    (liked-song song-lib-liked-2)
    (liked-song song-liked-only))
  (:goal (and (downloaded song-lib-liked-1)
              (downloaded song-lib-liked-2)
              (task-completed))))
