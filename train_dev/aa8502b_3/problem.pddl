(define (problem task-aa8502b-3)
  (:domain appworld-aa8502b-3)
  (:objects
    vickie-powell - person
    vicpowe-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 other-song - song
  )
  (:init
    (username-for spotify vicpowe-at-gmail-com)
    (password-for spotify spotify-password)
    (liked liked-song-1)
    (liked liked-song-2)
    (sings artist-1 liked-song-1)
    (sings artist-2 liked-song-2)
    (sings artist-3 liked-song-1)
    (sings artist-4 other-song)
    (following artist-3)
  )
  (:goal (and
    (following artist-1)
    (following artist-2)
    (following artist-3)
    (task-completed)
  ))
)
