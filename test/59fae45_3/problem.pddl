(define (problem task-59fae45-3)
  (:domain appworld-59fae45-3)
  (:objects
    kayla-burton - person
    ka-burt-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1-1 song-1-2 song-1-3 song-2-1 song-2-2 song-2-3 - song
    genre-pop genre-rock genre-jazz - genre
    new-title-1 new-title-2 - title
    n0 n1 n2 n3 - count
  )
  (:init
    (username-for spotify ka-burt-at-gmail-com)
    (password-for spotify spotify-password)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (in-playlist song-1-1 playlist-1)
    (in-playlist song-1-2 playlist-1)
    (in-playlist song-1-3 playlist-1)
    (in-playlist song-2-1 playlist-2)
    (in-playlist song-2-2 playlist-2)
    (in-playlist song-2-3 playlist-2)
    (song-genre song-1-1 genre-pop)
    (song-genre song-1-2 genre-pop)
    (song-genre song-1-3 genre-rock)
    (song-genre song-2-1 genre-jazz)
    (song-genre song-2-2 genre-rock)
    (song-genre song-2-3 genre-jazz)
    (song-count playlist-1 n3)
    (song-count playlist-2 n3)
    (genres-known-count playlist-1 n0)
    (genres-known-count playlist-2 n0)
    (most-common-genre playlist-1 genre-pop)
    (most-common-genre playlist-2 genre-jazz)
    (new-title playlist-1 genre-pop new-title-1)
    (new-title playlist-2 genre-jazz new-title-2)
    (playlist-count n2)
    (updated-count n0)
  )
  (:goal (and
    (title-updated playlist-1 new-title-1)
    (title-updated playlist-2 new-title-2)
    (task-completed)
  ))
)
