(define (problem task-ccb4494-1)
  (:domain appworld-ccb4494-1)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-upcoming - song)
  (:init
    (supervisor-username carbrown-at-gmail-com)
    (password-for spotify spotify-password)
    (played-so-far song-queue-1)
    (played-so-far song-queue-2)
    (played-so-far song-current))
  (:goal (and (liked song-queue-1)
              (liked song-queue-2)
              (liked song-current)
              (task-completed)))
)
