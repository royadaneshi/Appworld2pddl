(define (problem task-325d6ec-3)
  (:domain appworld-325d6ec-3)
  (:objects
    anthony - person
    an-harrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-a song-b song-c - song)
  (:init
    (password-for spotify spotify-password)
    (current-song song-a)
    (next-in-queue song-a song-b)
    (next-in-queue song-b song-c)
    (liked song-c))
  (:goal (and (reached-liked-song) (task-completed))))
