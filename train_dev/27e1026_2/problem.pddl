(define (problem task-27e1026-2)
  (:domain appworld-27e1026-2)
  (:objects
    jessica-miller - person
    jes-mill-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    newest-released-song - song
    newest-released-song-title - title)
  (:init
    (username-for spotify jes-mill-at-gmail-com)
    (password-for spotify spotify-password)
    (newest-candidate newest-released-song)
    (title-of newest-released-song newest-released-song-title))
  (:goal (and (found-newest-title newest-released-song newest-released-song-title) (task-completed))))
