(define (problem task-325d6ec-2)
  (:domain appworld-325d6ec-2)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-a song-1 song-2 song-3 song-c - song
  )
  (:init
    (password-for spotify spotify-password)
    (cursor-at song-a)
    (queue-next song-a song-1)
    (queue-next song-1 song-2)
    (queue-next song-2 song-3)
    (queue-next song-3 song-c)
    (downloaded song-c))
  (:goal (and
    (cursor-at song-c)
    (task-completed)))
)
