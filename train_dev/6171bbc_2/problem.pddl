(define (problem task-6171bbc-2)
  (:domain appworld-6171bbc-2)
  (:objects
    ashlee-martinez - person
    ashlee-martinez-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    title-my-highest-rated-playlist-songs - title
    my-highest-rated-playlist-songs playlist-1 playlist-2 - playlist
    song-1a song-1b song-2a song-2b - song)
  (:init
    (password-for spotify spotify-password)
    (user-playlist playlist-1)
    (user-playlist playlist-2)
    (new-playlist my-highest-rated-playlist-songs)
    (in-playlist song-1a playlist-1)
    (in-playlist song-1b playlist-1)
    (in-playlist song-2a playlist-2)
    (in-playlist song-2b playlist-2)
    (highest-rated playlist-1 song-1a)
    (highest-rated playlist-2 song-2b))
  (:goal (and
    (playlist-titled my-highest-rated-playlist-songs title-my-highest-rated-playlist-songs)
    (added-highest-rated playlist-1 my-highest-rated-playlist-songs)
    (added-highest-rated playlist-2 my-highest-rated-playlist-songs)
    (task-completed)))
)
