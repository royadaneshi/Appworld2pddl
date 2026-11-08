(define (problem task-59fae45-2)
  (:domain appworld-59fae45-2)
  (:objects
    chelsea-burch - person
    chelsea-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1-1 song-1-2 song-1-3 song-2-1 song-2-2 - song
    new-title-playlist-1 new-title-playlist-2 - title
    c0 c1 c2 c3 - count)
  (:init
    (password-for spotify spotify-password)
    (owned-playlist playlist-1)
    (owned-playlist playlist-2)
    (in-playlist song-1-1 playlist-1)
    (in-playlist song-1-2 playlist-1)
    (in-playlist song-1-3 playlist-1)
    (in-playlist song-2-1 playlist-2)
    (in-playlist song-2-2 playlist-2)
    (song-count playlist-1 c3)
    (song-count playlist-2 c2)
    (playlist-count c2)
    (count-next c0 c1)
    (count-next c1 c2)
    (count-next c2 c3)
    (new-title-for playlist-1 new-title-playlist-1)
    (new-title-for playlist-2 new-title-playlist-2)
    (songs-checked playlist-1 c0)
    (songs-checked playlist-2 c0)
    (playlists-updated c0))
  (:goal (and
    (title-updated playlist-1)
    (title-updated playlist-2)
    (playlists-updated c2)
    (task-completed))))
