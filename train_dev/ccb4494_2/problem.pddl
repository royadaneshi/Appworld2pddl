(define (problem task-ccb4494-2)
  (:domain appworld-ccb4494-2)
  (:objects
    catherine - person
    ca-smit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-2 song-91 song-168 song-137 song-250 song-227 song-130 song-142 song-194 song-18 - song
  )
  (:init
    (supervisor catherine)
    (supervisor-username ca-smit-at-gmail-com)
    (password-for spotify spotify-password)
    (queue-first song-2)
    (queue-next song-2 song-91)
    (queue-next song-91 song-168)
    (queue-next song-168 song-137)
    (queue-next song-137 song-250)
    (queue-next song-250 song-227)
    (queue-next song-227 song-130)
    (queue-next song-130 song-142)
    (queue-next song-142 song-194)
    (queue-next song-194 song-18)
    (current-song song-227)
    (played-so-far song-2)
    (played-so-far song-91)
    (played-so-far song-168)
    (played-so-far song-137)
    (played-so-far song-250)
    (played-so-far song-227))
  (:goal (and
    (liked song-2)
    (liked song-91)
    (liked song-168)
    (liked song-137)
    (liked song-250)
    (liked song-227)
    (task-completed))))
