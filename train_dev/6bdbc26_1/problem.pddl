(define (problem task-6bdbc26-1)
  (:domain appworld-6bdbc26-1)
  (:objects
    allison - person
    allison-calhoun-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    current-song - song
    current-artist - artist
    follower-count - count)
  (:init
    (username-for spotify allison-calhoun-at-gmail-com)
    (password-for spotify spotify-password)
    (playing-song current-song)
    (song-artist current-song current-artist)
    (artist-follower-count current-artist follower-count))
  (:goal (and
    (found-follower-count current-artist follower-count)
    (task-completed)))
)
