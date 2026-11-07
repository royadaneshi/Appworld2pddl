(define (problem task-6171bbc-1)
  (:domain appworld-6171bbc-1)
  (:objects
    de-ritt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    album-1 album-2 - album
    top-song-album-1 top-song-album-2 - song
    my-most-played-album-songs - playlist
    title-my-most-played-album-songs - title)
  (:init
    (username-for spotify de-ritt-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library album-1)
    (in-library album-2)
    (song-in-album top-song-album-1 album-1)
    (song-in-album top-song-album-2 album-2)
    (most-played album-1 top-song-album-1)
    (most-played album-2 top-song-album-2))
  (:goal (and
    (playlist-created my-most-played-album-songs)
    (playlist-titled my-most-played-album-songs title-my-most-played-album-songs)
    (song-added my-most-played-album-songs top-song-album-1)
    (song-added my-most-played-album-songs top-song-album-2)
    (task-completed)))
)
