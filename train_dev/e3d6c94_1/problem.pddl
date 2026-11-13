(define (problem task-e3d6c94-1)
  (:domain appworld-e3d6c94-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    spotify-recommended-songs-playlist - playlist
    title-spotify-recommended-songs - title
    rec-song-1 rec-song-2 rec-song-6 rec-song-3 rec-song-7 rec-song-4 rec-song-5 - song
    classical pop - genre
    year-1 year-2 year-2021 year-2023 - year
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (target-genre classical)
    (current-year year-2023)
    (is-recommended rec-song-1)
    (is-recommended rec-song-2)
    (is-recommended rec-song-6)
    (is-recommended rec-song-3)
    (is-recommended rec-song-7)
    (is-recommended rec-song-4)
    (is-recommended rec-song-5)
    (song-genre rec-song-1 classical)
    (song-genre rec-song-2 pop)
    (song-genre rec-song-6 classical)
    (song-genre rec-song-3 classical)
    (song-genre rec-song-7 classical)
    (song-genre rec-song-4 pop)
    (song-genre rec-song-5 classical)
    (release-year rec-song-1 year-1)
    (release-year rec-song-2 year-2023)
    (release-year rec-song-6 year-2023)
    (release-year rec-song-3 year-2)
    (release-year rec-song-7 year-2023)
    (release-year rec-song-4 year-2023)
    (release-year rec-song-5 year-2021))
  (:goal (and
    (playlist-created spotify-recommended-songs-playlist)
    (playlist-title spotify-recommended-songs-playlist title-spotify-recommended-songs)
    (in-playlist spotify-recommended-songs-playlist rec-song-6)
    (in-playlist spotify-recommended-songs-playlist rec-song-7)
    (task-completed)))
)
