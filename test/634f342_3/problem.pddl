(define (problem task-634f342-3)
  (:domain appworld-634f342-3)
  (:objects
    jack-maldonado - person
    jack-maldonado-at-gmail-com - username
    file-system-password spotify-password - password
    token-file-system token-spotify - token
    documents-personal-list-of-old-songs-txt - file-path
    title-archived-playlist-songs - playlist-title)
  (:init
    (username-for file-system jack-maldonado-at-gmail-com)
    (username-for spotify jack-maldonado-at-gmail-com)
    (password-for file-system file-system-password)
    (password-for spotify spotify-password)
    (old-songs-file documents-personal-list-of-old-songs-txt)
    (old-song old-song-1)
    (old-song old-song-2)
    (preexisting-playlist playlist-1)
    (preexisting-playlist playlist-2)
    (song-in-playlist old-song-1 playlist-1)
    (song-in-playlist old-song-2 playlist-1)
    (song-in-playlist old-song-2 playlist-2)
    (has-title archived-playlist-songs title-archived-playlist-songs))
  (:goal (and
    (created-playlist archived-playlist-songs)
    (not (song-in-playlist old-song-1 playlist-1))
    (not (song-in-playlist old-song-2 playlist-1))
    (not (song-in-playlist old-song-2 playlist-2))
    (song-in-playlist old-song-1 archived-playlist-songs)
    (song-in-playlist old-song-2 archived-playlist-songs)
    (task-completed)))
)
