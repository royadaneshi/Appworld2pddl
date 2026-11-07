(define (problem task-c901732-2)
  (:domain appworld-c901732-2)
  (:objects
    susan - person
    susanmiller-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    woodstock-reimagined-festival-vibes - playlist
    most-played-song - song
  )
  (:init
    (username-for spotify susanmiller-at-gmail-com)
    (password-for spotify spotify-password)
    (my-playlist woodstock-reimagined-festival-vibes)
    (in-playlist most-played-song woodstock-reimagined-festival-vibes)
    (most-played most-played-song woodstock-reimagined-festival-vibes)
  )
  (:goal (and
    (playing most-played-song)
    (task-completed)
  ))
)
