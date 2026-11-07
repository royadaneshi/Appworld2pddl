(define (problem task-287e338-3)
  (:domain appworld-287e338-3)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    recommended-song - song
    top-artist - artist
    top-artist-name - artist-name
  )
  (:init
    (username-for spotify carbrown-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended recommended-song)
    (artist-of recommended-song top-artist)
    (artist-named top-artist top-artist-name)
  )
  (:goal (and (answer-known top-artist-name) (answered top-artist-name) (task-completed)))
)
