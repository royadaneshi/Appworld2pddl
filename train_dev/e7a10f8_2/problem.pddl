(define (problem task-e7a10f8-2)
  (:domain appworld-e7a10f8-2)
  (:objects
    ch-burch-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1-1 song-1-2 song-2-1 song-2-2 - song
    shortest-playlist-minutes - minutes
  )
  (:init
    (supervisor-email ch-burch-at-gmail-com)
    (password-for spotify spotify-password)
    (in-playlist song-1-1 playlist-1)
    (in-playlist song-1-2 playlist-1)
    (in-playlist song-2-1 playlist-2)
    (in-playlist song-2-2 playlist-2)
    (next-song song-1-1 song-1-2)
    (next-song song-1-2 song-2-1)
    (next-song song-2-1 song-2-2)
    (next-song song-2-2 song-2-2)
    (ready song-1-1)
    (last-song song-2-2)
  )
  (:goal (and
    (known-duration song-1-1)
    (known-duration song-1-2)
    (known-duration song-2-1)
    (known-duration song-2-2)
    (task-completed)
  ))
)
