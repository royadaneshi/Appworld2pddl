(define (problem task-b0a8eae-1)
  (:domain appworld-b0a8eae-1)
  (:objects
    timothy - person
    timothy-whit-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-workout - query
    workout-note - note
    workout-duration-today - duration
    long-enough-playlist - playlist
    playlist-song - song
  )
  (:init
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app spotify spotify-password)
    (credential-of-app spotify spotify-token)
    (supervisor-username timothy-whit-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (query-matches-note query-workout workout-note)
    (is-workout-note workout-note)
    (note-duration-for-today workout-note workout-duration-today)
    (in-library long-enough-playlist)
    (song-in-playlist playlist-song long-enough-playlist)
    (long-enough-for long-enough-playlist workout-duration-today)
  )
  (:goal (and
    (workout-playlist-playing)
    (task-completed)
  ))
)
