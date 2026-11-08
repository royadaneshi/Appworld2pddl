(define (problem task-09b0ee6-1)
  (:domain appworld-09b0ee6-1)
  (:objects
    denise - person
    deniseburch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 - playlist
    song-1 - song
    answer-top-6-artists - answer)
  (:init
    (password-for spotify spotify-password))
  (:goal (and
    (found-top-artists answer-top-6-artists)
    (task-completed))))
