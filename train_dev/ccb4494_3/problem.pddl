(define (problem task-ccb4494-3)
  (:domain appworld-ccb4494-3)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-1 song-2 song-3 song-4 song-5 song-6 song-7 song-8 song-9 song-10 - song
  )
  (:init
    (username-for spotify pa-ritter-at-gmail-com)
    (password-for spotify spotify-password)
    (in-queue song-1)
    (in-queue song-2)
    (in-queue song-3)
    (in-queue song-4)
    (in-queue song-5)
    (in-queue song-6)
    (in-queue song-7)
    (in-queue song-8)
    (in-queue song-9)
    (in-queue song-10)
    (current-song song-6)
    (played-so-far song-1)
    (played-so-far song-2)
    (played-so-far song-3)
    (played-so-far song-4)
    (played-so-far song-5)
    (played-so-far song-6))
  (:goal (and
    (liked song-1)
    (liked song-2)
    (liked song-3)
    (liked song-4)
    (liked song-5)
    (liked song-6)
    (task-completed)))
)
