(define (problem task-425a494-1)
  (:domain appworld-425a494-1)
  (:objects
    jacob-blackburn - person
    jac-blackburn-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    most-liked-genre - genre)
  (:init
    (password-for spotify spotify-password))
  (:goal (and (found-most-liked-genre most-liked-genre) (task-completed)))
)
