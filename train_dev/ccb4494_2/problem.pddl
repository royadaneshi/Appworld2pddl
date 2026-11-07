(define (problem task-ccb4494-2)
  (:domain appworld-ccb4494-2)
  (:objects
    catherine - person
    ca-smit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-queue-1 song-queue-2 song-current song-queue-4 - song)
  (:init
    (supervisor catherine)
    (supervisor-username ca-smit-at-gmail-com)
    (password-for spotify spotify-password)
    (queue-first song-queue-1)
    (queue-next song-queue-1 song-queue-2)
    (queue-next song-queue-2 song-current)
    (queue-next song-current song-queue-4)
    (queue-next song-queue-4 song-queue-1)
    (current-song song-current)
    (played-so-far song-queue-1)
    (played-so-far song-queue-2)
    (played-so-far song-current))
  (:goal (and
    (liked song-queue-1)
    (liked song-queue-2)
    (liked song-current)
    (task-completed))))
