(define (problem task-425a494-2)
  (:domain appworld-425a494-2)
  (:objects
    jennifer-powell - person
    jepowell-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-album - album
    library-album-song - song
    least-liked-genre - genre)
  (:init
    (username-for spotify jepowell-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library library-album)
    (song-in-album library-album-song library-album)
    (song-genre library-album-song least-liked-genre))
  (:goal (and (found-least-liked-genre least-liked-genre) (task-completed)))
)
