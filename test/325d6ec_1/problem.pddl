(define (problem task-325d6ec-1)
  (:domain appworld-325d6ec-1)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-current song-previous-1 song-previous-2 song-previous-3 song-previous-4 song-previous-5 - song
  )
  (:init
    (password-for spotify spotify-password)
    (current-song song-current)
    (prev-in-queue song-current song-previous-1)
    (prev-in-queue song-previous-1 song-previous-2)
    (prev-in-queue song-previous-2 song-previous-3)
    (prev-in-queue song-previous-3 song-previous-4)
    (prev-in-queue song-previous-4 song-previous-5)
    (liked song-previous-5))
  (:goal (and
    (current-song song-previous-5)
    (task-completed))))
