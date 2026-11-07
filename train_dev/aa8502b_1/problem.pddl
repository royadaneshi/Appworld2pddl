(define (problem task-aa8502b-1)
  (:domain appworld-aa8502b-1)
  (:objects
    troy - person
    tr-solo-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 liked-song-3 - song)
  (:init
    (supervisor-username tr-solo-at-gmail-com)
    (password-for spotify spotify-password)
    (liked liked-song-1)
    (liked liked-song-2)
    (liked liked-song-3)
    (sung-by liked-song-1 artist-a)
    (sung-by liked-song-2 artist-b)
    (sung-by liked-song-2 artist-c)
    (sung-by liked-song-3 artist-c)
    (following artist-c))
  (:goal (and (following artist-a)
              (following artist-b)
              (following artist-c)
              (task-completed))))
