(define (problem task-3ab5b8b-1)
  (:domain appworld-3ab5b8b-1)
  (:objects
    norman - person
    normansmit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-liked-in-playlist-1 song-liked-in-playlist-2 song-in-playlist-not-liked song-liked-not-in-playlist - song)
  (:init
    (supervisor-username normansmit-at-gmail-com)
    (password-for spotify spotify-password)
    (playlist-song song-liked-in-playlist-1)
    (playlist-song song-liked-in-playlist-2)
    (playlist-song song-in-playlist-not-liked)
    (liked-song song-liked-in-playlist-1)
    (liked-song song-liked-in-playlist-2)
    (liked-song song-liked-not-in-playlist))
  (:goal (and (downloaded song-liked-in-playlist-1)
              (downloaded song-liked-in-playlist-2)
              (task-completed))))
