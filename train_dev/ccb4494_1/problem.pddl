(define (problem task-ccb4494-1)
  (:domain appworld-ccb4494-1)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-40 song-71 song-50 song-66 - song
  )
  (:init
    (supervisor-username carbrown-at-gmail-com)
    (password-for spotify spotify-password)
    (played-so-far song-55)
    (played-so-far song-30)
    (played-so-far song-242)
    (played-so-far song-179)
    (played-so-far song-111)
    (played-so-far song-322))
  (:goal (and
    (liked song-55)
    (liked song-30)
    (liked song-242)
    (liked song-179)
    (liked song-111)
    (liked song-322)
    (task-completed)))
)
