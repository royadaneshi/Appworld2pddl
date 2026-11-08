(define (problem task-59fae45-1)
  (:domain appworld-59fae45-1)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    genre-playlist-1 genre-playlist-2 - genre
    new-title-playlist-1 new-title-playlist-2 - title)
  (:init
    (password-for spotify spotify-password)
    (in-library playlist-1)
    (in-library playlist-2)
    (genre-slot playlist-1 genre-playlist-1)
    (genre-slot playlist-2 genre-playlist-2)
    (derived-title playlist-1 genre-playlist-1 new-title-playlist-1)
    (derived-title playlist-2 genre-playlist-2 new-title-playlist-2))
  (:goal (and
    (title-updated playlist-1 new-title-playlist-1)
    (title-updated playlist-2 new-title-playlist-2)
    (task-completed)))
)
