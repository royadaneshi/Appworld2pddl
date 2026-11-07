(define (problem task-e3d6c94-2)
  (:domain appworld-e3d6c94-2)
  (:objects
    timothy - person
    timothy-whit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    title-spotify-rnb-recommendations - title
    spotify-rnb-recommendations-playlist - playlist
    rec-song-1 rec-song-2 rec-song-3 - song)
  (:init
    (password-for spotify spotify-password)
    (recommended rec-song-1)
    (recommended rec-song-2)
    (recommended rec-song-3)
    (genre-rnb rec-song-1)
    (released-recently rec-song-1)
    (genre-rnb rec-song-2)
    (released-recently rec-song-2)
    (genre-rnb rec-song-3))
  (:goal (and
    (playlist-created spotify-rnb-recommendations-playlist)
    (playlist-titled spotify-rnb-recommendations-playlist title-spotify-rnb-recommendations)
    (song-in-playlist rec-song-1 spotify-rnb-recommendations-playlist)
    (song-in-playlist rec-song-2 spotify-rnb-recommendations-playlist)
    (task-completed)))
)
