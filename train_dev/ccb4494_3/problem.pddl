(define (problem task-ccb4494-3)
  (:domain appworld-ccb4494-3)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-225 song-14 song-22 song-226 song-149 song-209 song-9 song-70 song-205 song-69 - song
  )
  (:init
    (username-for spotify pa-ritter-at-gmail-com)
    (password-for spotify spotify-password)
    (in-queue song-225)
    (in-queue song-14)
    (in-queue song-22)
    (in-queue song-226)
    (in-queue song-149)
    (in-queue song-209)
    (in-queue song-9)
    (in-queue song-70)
    (in-queue song-205)
    (in-queue song-69)
    (current-song song-209)
    (played-so-far song-225)
    (played-so-far song-14)
    (played-so-far song-22)
    (played-so-far song-226)
    (played-so-far song-149)
    (played-so-far song-209))
  (:goal (and
    (liked song-225)
    (liked song-14)
    (liked song-22)
    (liked song-226)
    (liked song-149)
    (liked song-209)
    (task-completed)))
)
