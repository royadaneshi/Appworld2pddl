(define (problem task-6bdbc26-2)
  (:domain appworld-6bdbc26-2)
  (:objects
    susan - person
    susanmiller-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    current-song - song
    current-artist - artist
    follower-count - count)
  (:init
    (supervisor-username susanmiller-at-gmail-com)
    (password-for spotify spotify-password)
    (song-artist current-song current-artist)
    (artist-follower-count current-artist follower-count))
  (:goal (and (answer-known follower-count)
              (task-completed)))
)
