(define (problem task-ccb4494-1)
  (:domain appworld-ccb4494-1)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-upcoming-1 song-upcoming-2 song-upcoming-3 song-upcoming-4 - song
  )
  (:init
    (supervisor-username carbrown-at-gmail-com)
    (password-for spotify spotify-password)
    (played-so-far song-queue-1)
    (played-so-far song-queue-2)
    (played-so-far song-queue-3)
    (played-so-far song-queue-4)
    (played-so-far song-queue-5)
    (played-so-far song-queue-6))
  (:goal (and
    (liked song-queue-1)
    (liked song-queue-2)
    (liked song-queue-3)
    (liked song-queue-4)
    (liked song-queue-5)
    (liked song-queue-6)
    (task-completed)))
)
