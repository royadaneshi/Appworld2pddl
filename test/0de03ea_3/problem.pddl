(define (problem task-0de03ea-3)
  (:domain appworld-0de03ea-3)
  (:objects
    matthew - person
    matthew-blac-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    album-enough-downloads album-few-downloads - album
    drive-20-minutes - duration)
  (:init
    (password-for spotify spotify-password)
    (in-library album-enough-downloads)
    (in-library album-few-downloads)
    (drive-duration drive-20-minutes)
    (downloaded-duration-covers album-enough-downloads drive-20-minutes))
  (:goal (and (suitable-album-playing) (task-completed)))
)
