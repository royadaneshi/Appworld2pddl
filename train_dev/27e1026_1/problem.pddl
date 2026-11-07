(define (problem task-27e1026-1)
  (:domain appworld-27e1026-1)
  (:objects
    erikabail-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    oldest-released-song - song
    title-of-oldest-song - song-title)
  (:init
    (supervisor-username erikabail-at-gmail-com)
    (password-for spotify spotify-password)
    (is-oldest oldest-released-song))
  (:goal (and
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (found-title oldest-released-song title-of-oldest-song)
    (task-completed)))
)
