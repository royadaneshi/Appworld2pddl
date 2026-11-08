(define (problem task-325d6ec-2)
  (:domain appworld-325d6ec-2)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-a song-b song-c - song)
  (:init
    (password-for spotify spotify-password)
    (cursor-at song-a)
    (queue-next song-a song-b)
    (queue-next song-b song-c)
    (queue-next song-c song-a)
    (downloaded song-c))
  (:goal (and (cursor-at song-c)
              (task-completed)))
)
