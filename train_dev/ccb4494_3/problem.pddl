(define (problem task-ccb4494-3)
  (:domain appworld-ccb4494-3)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-1 song-2 song-3 song-4 song-5 - song)
  (:init
    (username-for spotify pa-ritter-at-gmail-com)
    (password-for spotify spotify-password)
    (in-queue song-1)
    (in-queue song-2)
    (in-queue song-3)
    (in-queue song-4)
    (in-queue song-5)
    (current-song song-3)
    (played-so-far song-1)
    (played-so-far song-2)
    (played-so-far song-3))
  (:goal (and
    (liked song-1)
    (liked song-2)
    (liked song-3)
    (task-completed)))
)
