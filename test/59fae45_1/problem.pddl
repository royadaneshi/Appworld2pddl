(define (problem task-59fae45-1)
  (:domain appworld-59fae45-1)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 playlist-3 playlist-4 - playlist
    new-title-playlist-1 new-title-playlist-2 new-title-playlist-3 new-title-playlist-4 - title
    genre-playlist-1 genre-playlist-2 genre-playlist-3 genre-playlist-4 - genre
  )
  (:init
    (password-for spotify spotify-password)
    (in-library playlist-1)
    (in-library playlist-2)
    (in-library playlist-3)
    (in-library playlist-4)
    (genre-slot playlist-1 genre-playlist-1)
    (genre-slot playlist-2 genre-playlist-2)
    (genre-slot playlist-3 genre-playlist-3)
    (genre-slot playlist-4 genre-playlist-4)
    (derived-title playlist-1 genre-playlist-1 new-title-playlist-1)
    (derived-title playlist-2 genre-playlist-2 new-title-playlist-2)
    (derived-title playlist-3 genre-playlist-3 new-title-playlist-3)
    (derived-title playlist-4 genre-playlist-4 new-title-playlist-4))
  (:goal (and
    (title-updated playlist-1 new-title-playlist-1)
    (title-updated playlist-2 new-title-playlist-2)
    (title-updated playlist-3 new-title-playlist-3)
    (title-updated playlist-4 new-title-playlist-4)
    (task-completed)))
)
