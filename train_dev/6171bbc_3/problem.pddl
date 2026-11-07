(define (problem task-6171bbc-3)
  (:domain appworld-6171bbc-3)
  ; spotify, new-playlist, top-song-1 and top-song-2 are domain constants
  (:objects
    jepowell-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    title-most-listened-playlist-songs - title
    playlist-1 playlist-2 - playlist
    other-song-1 other-song-2 - song)
  (:init
    (username-for spotify jepowell-at-gmail-com)
    (password-for spotify spotify-password)
    (owned-playlist playlist-1)
    (owned-playlist playlist-2)
    (playlist-title new-playlist title-most-listened-playlist-songs)
    (in-playlist top-song-1 playlist-1)
    (in-playlist other-song-1 playlist-1)
    (in-playlist top-song-2 playlist-2)
    (in-playlist other-song-2 playlist-2)
    (most-played-in top-song-1 playlist-1)
    (most-played-in top-song-2 playlist-2))
  (:goal (and (created new-playlist)
              (added top-song-1 new-playlist)
              (added top-song-2 new-playlist)
              (task-completed))))
