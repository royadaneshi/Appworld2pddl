(define (problem task-07b42fd-3)
  (:domain appworld-07b42fd-3)
  (:objects
    morgan - person
    morgan-harrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    query-reggae - query
    reggae - genre
    followers-21 - follower-count
    artist-luna-starlight - artist)
  (:init
    (username-for spotify morgan-harrison-at-gmail-com)
    (password-for spotify spotify-password)
    (target-genre reggae)
    (target-min-followers followers-21)
    (query-for-genre query-reggae reggae)
    (matching-artist artist-luna-starlight))
  (:goal (and (followed artist-luna-starlight) (task-completed)))
)
