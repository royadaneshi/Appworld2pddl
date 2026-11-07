(define (problem task-e3d6c94-1)
  (:domain appworld-e3d6c94-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    rec-song-1 rec-song-2 rec-song-3 rec-song-4 - song
    spotify-recommended-songs-playlist - playlist
    title-spotify-recommended-songs - title
    classical pop - genre
    year-2023 year-2021 - year)
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (target-genre classical)
    (current-year year-2023)
    (is-recommended rec-song-1)
    (is-recommended rec-song-2)
    (is-recommended rec-song-3)
    (is-recommended rec-song-4)
    (song-genre rec-song-1 classical)
    (release-year rec-song-1 year-2023)
    (song-genre rec-song-2 classical)
    (release-year rec-song-2 year-2023)
    (song-genre rec-song-3 classical)
    (release-year rec-song-3 year-2021)
    (song-genre rec-song-4 pop)
    (release-year rec-song-4 year-2023))
  (:goal (and
    (playlist-created spotify-recommended-songs-playlist)
    (playlist-title spotify-recommended-songs-playlist title-spotify-recommended-songs)
    (in-playlist spotify-recommended-songs-playlist rec-song-1)
    (in-playlist spotify-recommended-songs-playlist rec-song-2)
    (task-completed)))
)
