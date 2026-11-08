(define (problem task-634f342-1)
  (:domain appworld-634f342-1)
  (:objects
    edwin-wilson - person
    ed-wilson-at-gmail-com - username
    file-system-password spotify-password - password
    file-system-token spotify-token - token
    old-songs-file - path
    archived-songs-title - title)
  (:init
    (password-for file-system file-system-password)
    (password-for spotify spotify-password)
    (listed-in-file old-song-1 old-songs-file)
    (listed-in-file old-song-2 old-songs-file)
    (playlist-exists playlist-1)
    (playlist-exists playlist-2)
    (in-playlist old-song-1 playlist-1)
    (in-playlist old-song-1 playlist-2)
    (in-playlist old-song-2 playlist-2)
    (playlist-title archived-songs archived-songs-title))
  (:goal (and
    (created-playlist archived-songs)
    (in-playlist old-song-1 archived-songs)
    (in-playlist old-song-2 archived-songs)
    (not (in-playlist old-song-1 playlist-1))
    (not (in-playlist old-song-1 playlist-2))
    (not (in-playlist old-song-2 playlist-1))
    (not (in-playlist old-song-2 playlist-2))
    (task-completed)))
)
