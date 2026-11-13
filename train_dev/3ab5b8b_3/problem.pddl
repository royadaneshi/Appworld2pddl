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
    (in-album-library song-31)
    (in-album-library song-32)
    (in-album-library song-48)
    (in-album-library song-49)
    (in-album-library song-50)
    (in-album-library song-51)
    (in-album-library song-52)
    (in-album-library song-57)
    (liked-song song-31)
    (liked-song song-32)
    (liked-song song-48)
    (liked-song song-49)
    (liked-song song-50)
    (liked-song song-51)
    (liked-song song-52)
    (liked-song song-57))
  (:goal (and
    (downloaded song-31)
    (downloaded song-32)
    (downloaded song-48)
    (downloaded song-49)
    (downloaded song-50)
    (downloaded song-51)
    (downloaded song-52)
    (downloaded song-57)
    (task-completed))))
