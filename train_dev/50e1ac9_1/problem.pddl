(define (problem task-50e1ac9-1)
  (:domain appworld-50e1ac9-1)
  (:objects
    glenn-burton-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song album-song playlist-song - song
    library-album - album
    library-playlist - playlist
    top-4-rb-titles - answer)
  (:init
    (username-for spotify glenn-burton-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library library-song)
    (in-album-library library-album)
    (album-has-song library-album album-song)
    (in-playlist-library library-playlist)
    (playlist-has-song library-playlist playlist-song)
    (answer-covers top-4-rb-titles library-song)
    (answer-covers top-4-rb-titles album-song)
    (answer-covers top-4-rb-titles playlist-song))
  (:goal (and
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (song-details-known library-song)
    (song-details-known album-song)
    (song-details-known playlist-song)
    (task-completed)))
)
