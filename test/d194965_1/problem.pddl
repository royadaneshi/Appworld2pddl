(define (problem task-d194965-1)
  (:domain appworld-d194965-1)
  (:objects
    katherine-smith - person
    ka-ball-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-songs query-song-1 query-song-2 query-song-3 - query
    songs-note - note
    song-1 song-2 song-3 - song
    random-songs-playlist - playlist
    title-random-songs - title
  )
  (:init
    (username-for simple-note ka-ball-at-gmail-com)
    (username-for spotify ka-ball-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (token-for simple-note simple-note-token)
    (token-for spotify spotify-token)
    (query-for-note query-songs songs-note)
    (song-in-note songs-note song-1)
    (song-in-note songs-note song-2)
    (song-in-note songs-note song-3)
    (query-for-song query-song-1 song-1)
    (query-for-song query-song-2 song-2)
    (query-for-song query-song-3 song-3)
  )
  (:goal (and
    (playlist-created random-songs-playlist title-random-songs)
    (song-added random-songs-playlist song-1)
    (song-added random-songs-playlist song-2)
    (song-added random-songs-playlist song-3)
    (task-completed)
  ))
)
