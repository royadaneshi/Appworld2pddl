(define (problem task-b0a8eae-3)
  (:domain appworld-b0a8eae-3)
  (:objects
    erica-wilson - person
    eri-powe-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-workout - query
    workout-plan-note - note
    workout-duration-today - duration
    long-enough-playlist - playlist
    long-enough-playlist-songs - song
  )
  (:init
    (supervisor-email eri-powe-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (note-query workout-plan-note query-workout)
    (workout-note workout-plan-note)
    (song-in-playlist long-enough-playlist-songs long-enough-playlist)
  )
  (:goal (and
    (workout-playlist-playing)
    (task-completed)
  ))
)
