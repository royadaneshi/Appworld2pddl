(define (problem task-d194965-3)
  (:domain appworld-d194965-3)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-songs query-song-1 query-song-2 query-song-3 - query
    songs-note - note
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (note-matches songs-note query-songs)
    (song-in-note song-1 songs-note)
    (song-in-note song-2 songs-note)
    (song-in-note song-3 songs-note)
    (song-query song-1 query-song-1)
    (song-query song-2 query-song-2)
    (song-query song-3 query-song-3)
  )
  (:goal (and
    (playlist-created random-playlist)
    (playlist-titled random-playlist random-playlist-title)
    (song-in-playlist song-1 random-playlist)
    (song-in-playlist song-2 random-playlist)
    (song-in-playlist song-3 random-playlist)
    (task-completed)
  ))
)
