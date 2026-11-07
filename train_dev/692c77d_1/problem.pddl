(define (problem task-692c77d-1)
  (:domain appworld-692c77d-1)
  (:objects
    as-moore-at-gmail-com - email
    spotify-password - password
    spotify-token - token
    song-c - song
    review-b review-d - review)
  (:init
    (supervisor-email as-moore-at-gmail-com)
    (password-for spotify spotify-password)
    (target-rating rating-5)
    (in-playlist song-a)
    (liked song-a)
    (in-playlist song-b)
    (liked song-b)
    (has-existing-review song-b)
    (review-of review-b song-b)
    (in-playlist song-c)
    (in-playlist song-d)
    (liked song-d)
    (has-existing-review song-d)
    (review-of review-d song-d)
    (rated song-d rating-5))
  (:goal (and (rated song-a rating-5) (rated song-b rating-5) (rated song-d rating-5) (task-completed)))
)
