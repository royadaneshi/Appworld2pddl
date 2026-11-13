(define (problem task-ccb4494-2)
  (:domain appworld-ccb4494-2)
  (:objects
    catherine - person
    ca-smit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-queue-1 song-queue-2 song-queue-3 song-queue-4 song-queue-5 song-current song-queue-6 song-queue-7 song-queue-8 song-queue-9 - song
  )
  (:init
    (supervisor catherine)
    (supervisor-username ca-smit-at-gmail-com)
    (password-for spotify spotify-password)
    (queue-first song-queue-1)
    (queue-next song-queue-1 song-queue-2)
    (queue-next song-queue-2 song-queue-3)
    (queue-next song-queue-3 song-queue-4)
    (queue-next song-queue-4 song-queue-5)
    (queue-next song-queue-5 song-current)
    (queue-next song-current song-queue-6)
    (queue-next song-queue-6 song-queue-7)
    (queue-next song-queue-7 song-queue-8)
    (queue-next song-queue-8 song-queue-9)
    (current-song song-current)
    (played-so-far song-queue-1)
    (played-so-far song-queue-2)
    (played-so-far song-queue-3)
    (played-so-far song-queue-4)
    (played-so-far song-queue-5)
    (played-so-far song-current))
  (:goal (and
    (liked song-queue-1)
    (liked song-queue-2)
    (liked song-queue-3)
    (liked song-queue-4)
    (liked song-queue-5)
    (liked song-current)
    (task-completed))))
