(define (problem task-425a494-3)
  (:domain appworld-425a494-3)
  (:objects
    jose - person
    joseharr-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    my-playlist - playlist
    playlist-song - song
    most-liked-genre - genre)
  (:init
    (password-for spotify spotify-password))
  (:goal (and
    (playlists-known)
    (playlist-songs-known)
    (liked-songs-known)
    (found-most-liked-genre most-liked-genre)
    (task-completed))))
