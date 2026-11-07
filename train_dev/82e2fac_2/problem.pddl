(define (problem task-82e2fac-2)
  (:domain appworld-82e2fac-2)
  (:objects
    glenn-burton - person
    glenn-burton-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    least-played-song - song
    least-played-song-title - song-title
  )
  (:init
    (supervisor-username glenn-burton-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library least-played-song)
    (least-played least-played-song)
    (title-of least-played-song least-played-song-title)
  )
  (:goal (and (details-known least-played-song) (task-completed)))
)
