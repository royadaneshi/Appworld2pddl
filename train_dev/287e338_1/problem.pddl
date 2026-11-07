(define (problem task-287e338-1)
  (:domain appworld-287e338-1)
  (:objects
    kyle-moore - person
    kyl-moor-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    recommended-song - song
    top-artist - artist
    top-artist-name - artist-name)
  (:init
    (supervisor-username kyl-moor-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended recommended-song)
    (song-by recommended-song top-artist)
    (most-recommended top-artist)
    (name-of top-artist top-artist-name))
  (:goal (and (recommendations-fetched)
              (found-recommended-artist top-artist)
              (found-artist-name top-artist top-artist-name)
              (task-completed)))
)
