(define (problem task-634f342-2)
  (:domain appworld-634f342-2)
  (:objects
    vickie - person
    vicpowe-at-gmail-com - username
    pw-file-system pw-spotify - password
    tok-file-system tok-spotify - token
    songs-to-archive-txt - path
    query-song-1 query-song-2 query-song-3 - query
    playlist-1 playlist-2 old-songs - playlist
    song-1 song-2 song-3 song-4 - song
    title-old-songs - playlist-title)
  (:init
    (username-for file-system vicpowe-at-gmail-com)
    (username-for spotify vicpowe-at-gmail-com)
    (password-for file-system pw-file-system)
    (password-for spotify pw-spotify)
    (archive-list-file songs-to-archive-txt)
    (archive-song song-1)
    (archive-song song-2)
    (archive-song song-3)
    (song-query song-1 query-song-1)
    (song-query song-2 query-song-2)
    (song-query song-3 query-song-3)
    (playlist-exists playlist-1)
    (playlist-exists playlist-2)
    (in-playlist playlist-1 song-1)
    (in-playlist playlist-1 song-2)
    (in-playlist playlist-1 song-4)
    (in-playlist playlist-2 song-2)
    (in-playlist playlist-2 song-3))
  (:goal (and
    (playlist-titled old-songs title-old-songs)
    (not (in-playlist playlist-1 song-1))
    (not (in-playlist playlist-1 song-2))
    (not (in-playlist playlist-2 song-2))
    (not (in-playlist playlist-2 song-3))
    (in-playlist old-songs song-1)
    (in-playlist old-songs song-2)
    (in-playlist old-songs song-3)
    (task-completed)))
)
