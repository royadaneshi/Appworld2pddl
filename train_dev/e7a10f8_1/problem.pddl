(define (problem task-e7a10f8-1)
  (:domain appworld-e7a10f8-1)
  (:objects
    anita-burch - person
    anita-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    library-playlist - playlist
    playlist-song - song
    longest-minutes - minutes
  )
  (:init
    (username-for spotify anita-burch-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library library-playlist)
    (song-in library-playlist playlist-song)
    (minutes-of library-playlist longest-minutes)
  )
  (:goal (and
    (found-longest-minutes longest-minutes)
    (task-completed)
  ))
)
