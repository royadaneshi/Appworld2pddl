(define (problem task-325d6ec-3)
  (:domain appworld-325d6ec-3)
  (:objects
    anthony - person
    an-harrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-a song-1 song-2 song-3 song-c - song
  )
  (:init
    (password-for spotify spotify-password)
    (current-song song-a)
    (next-in-queue song-a song-1)
    (next-in-queue song-1 song-2)
    (next-in-queue song-2 song-3)
    (next-in-queue song-3 song-c)
    (liked song-c))
  (:goal (and
    (reached-liked-song)
    (task-completed))))
