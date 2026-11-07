(define (problem task-b0a8eae-2)
  (:domain appworld-b0a8eae-2)
  (:objects
    ch-brow-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-workout - query
    wednesday - weekday
    workout-duration-today - duration
    workout-plan-note - note
    playlist-long-enough playlist-too-short - playlist
    song-1 song-2 song-3 - song)
  (:init
    (supervisor-username ch-brow-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (token-for simple-note simple-note-token)
    (token-for spotify spotify-token)
    (current-weekday wednesday)
    (note-matches workout-plan-note query-workout)
    (plan-duration workout-plan-note wednesday workout-duration-today)
    (song-to-check playlist-long-enough song-1)
    (followed-by playlist-long-enough song-1 song-2)
    (followed-by playlist-long-enough song-2 song-1)
    (last-song playlist-long-enough song-2)
    (song-to-check playlist-too-short song-3)
    (followed-by playlist-too-short song-3 song-3)
    (last-song playlist-too-short song-3)
    (long-enough playlist-long-enough workout-duration-today))
  (:goal (and (playing-playlist playlist-long-enough) (task-completed))))
