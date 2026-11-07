(define (problem task-4ec8de5-1)
  (:domain appworld-4ec8de5-1)
  (:objects
    cheweber-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-song - song
    answer-count - count)
  (:init
    (supervisor-username cheweber-at-gmail-com)
    (password-for spotify spotify-password)
    (in-song-library library-song))
  (:goal (and
    (current-date-known)
    (song-library-listed)
    (album-library-listed)
    (library-song-release-dates-known)
    (task-completed))))
