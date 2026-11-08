(define (problem task-325d6ec-1)
  (:domain appworld-325d6ec-1)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-current song-previous-1 song-previous-2 - song)
  (:init
    (password-for spotify spotify-password)
    (current-song song-current)
    (prev-in-queue song-current song-previous-1)
    (prev-in-queue song-previous-1 song-previous-2)
    (liked song-previous-2))
  (:goal (and (current-song song-previous-2) (task-completed))))
