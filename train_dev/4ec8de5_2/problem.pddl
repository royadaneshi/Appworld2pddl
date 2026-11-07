(define (problem task-4ec8de5-2)
  (:domain appworld-4ec8de5-2)
  (:objects
    bradley-ball - person
    bradley-ball-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song - song
    count-songs-released-this-year - count
  )
  (:init
    (is-supervisor bradley-ball)
    (supervisor-username bradley-ball-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library library-song)
    (answer-count count-songs-released-this-year)
  )
  (:goal (and
    (current-date-known)
    (song-library-listed)
    (album-library-listed)
    (song-release-dates-known)
    (task-completed)
  ))
)
