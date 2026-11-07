(define (problem task-50e1ac9-3)
  (:domain appworld-50e1ac9-3)
  (:objects
    edwin-wilson - person
    ed-wilson-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    song-lib-1 song-alb-1 song-pl-1 - song
    album-1 - album
    playlist-1 - playlist
    top3-indie-titles - answer)
  (:init
    (username-of edwin-wilson ed-wilson-at-gmail-com)
    (supervisor-username ed-wilson-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library song-lib-1)
    (in-album-library album-1)
    (in-album song-alb-1 album-1)
    (in-playlist-library playlist-1)
    (in-playlist song-pl-1 playlist-1)
    (answer-from top3-indie-titles song-lib-1 song-alb-1 song-pl-1))
  (:goal (and
    (song-details-known song-lib-1)
    (song-details-known song-alb-1)
    (song-details-known song-pl-1)
    (task-completed)))
)
