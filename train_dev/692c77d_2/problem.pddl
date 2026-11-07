(define (problem task-692c77d-2)
  (:domain appworld-692c77d-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - email
    spotify-password - password
    spotify-token - token
    rating-1 - rating
    song-lib-unreviewed song-lib-reviewed song-lib-liked - song
    review-of-song-lib-reviewed - review)
  (:init
    (password-for spotify spotify-password)
    (supervisor-email brenda-webe-at-gmail-com)
    (target-rating rating-1)
    (in-library song-lib-unreviewed)
    (in-library song-lib-reviewed)
    (in-library song-lib-liked)
    (liked song-lib-liked)
    (unreviewed song-lib-unreviewed)
    (has-review song-lib-reviewed review-of-song-lib-reviewed))
  (:goal (and (rated-one song-lib-unreviewed)
              (rated-one song-lib-reviewed)
              (task-completed))))
