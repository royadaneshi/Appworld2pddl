(define (problem task-ce359b5-1)
  (:domain appworld-ce359b5-1)
  (:objects
    christopher-burch - person
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1 song-2 song-3 song-4 song-5 - song
    n1 n2 n3 n4 - count)
  (:init
    ; credentials (concrete values are discovered at runtime)
    (username-for spotify ch-burch-at-gmail-com)
    (password-for spotify spotify-password)
    ; song library membership (discovered via spotify.show_song_library)
    (contains song-library song-1)
    (contains song-library song-2)
    (contains song-library song-3)
    ; playlist membership (discovered via show_playlist_library + show_playlist)
    (contains playlist-1 song-1)
    (contains playlist-1 song-4)
    (contains playlist-2 song-2)
    (contains playlist-2 song-5)
    ; release-date facts (discovered via spotify.show_song): release_date.year < 2021
    (released-before-2021 song-1)
    (released-before-2021 song-3)
    (released-before-2021 song-5)
    ; countdown of required removals: 2 library links + 2 playlist links = 4
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (succ n3 n4)
    (pending-removals n4))
  (:goal (and (pending-removals n0)
              (task-completed))))
