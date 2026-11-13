(define (problem task-e3d6c94-1)
  (:domain appworld-e3d6c94-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    spotify-recommended-songs-playlist - playlist
    title-spotify-recommended-songs - title
    song-162 song-228 song-265 song-270 song-273 song-302 song-305 - song
    classical r-b - genre
    year-2019 year-2020 year-2021 year-2023 - year
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (target-genre classical)
    (current-year year-2023)
    (is-recommended song-162)
    (is-recommended song-228)
    (is-recommended song-265)
    (is-recommended song-270)
    (is-recommended song-273)
    (is-recommended song-302)
    (is-recommended song-305)
    (song-genre song-162 classical)
    (song-genre song-228 r-b)
    (song-genre song-265 classical)
    (song-genre song-270 classical)
    (song-genre song-273 classical)
    (song-genre song-302 r-b)
    (song-genre song-305 classical)
    (release-year song-162 year-2019)
    (release-year song-228 year-2023)
    (release-year song-265 year-2023)
    (release-year song-270 year-2020)
    (release-year song-273 year-2023)
    (release-year song-302 year-2023)
    (release-year song-305 year-2021))
  (:goal (and
    (playlist-created spotify-recommended-songs-playlist)
    (playlist-title spotify-recommended-songs-playlist title-spotify-recommended-songs)
    (in-playlist spotify-recommended-songs-playlist song-265)
    (in-playlist spotify-recommended-songs-playlist song-273)
    (task-completed)))
)
