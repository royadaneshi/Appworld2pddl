(define (problem task-e7a10f8-3)
  (:domain appworld-e7a10f8-3)
  (:objects
    isaac-miller - person
    ismill-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1-1 song-1-2 song-2-1 song-2-2 - song
    minutes-answer - minutes)
  (:init
    (username-for spotify ismill-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library playlist-1)
    (in-library playlist-2)
    (in-playlist song-1-1 playlist-1)
    (in-playlist song-1-2 playlist-1)
    (in-playlist song-2-1 playlist-2)
    (in-playlist song-2-2 playlist-2)
    (next-item song-1-1 song-1-2)
    (next-item song-1-2 song-2-1)
    (next-item song-2-1 song-2-2)
    (next-item song-2-2 minutes-answer)
    (unlocked song-1-1))
  (:goal (and (unlocked minutes-answer) (task-completed))))
