(define (problem task-692c77d-2)
  (:domain appworld-692c77d-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - email
    spotify-password - password
    spotify-token - token
    rating-1 - rating
    song-lib-unreviewed-1 song-lib-unreviewed-2 song-lib-unreviewed-3 song-lib-unreviewed-4 song-lib-unreviewed-5 song-lib-reviewed-1 song-lib-reviewed-2 - song
    review-of-song-lib-reviewed-1 review-of-song-lib-reviewed-2 - review
  )
  (:init
    (password-for spotify spotify-password)
    (supervisor-email brenda-webe-at-gmail-com)
    (target-rating rating-1)
    (in-library song-lib-unreviewed-1)
    (in-library song-lib-unreviewed-2)
    (in-library song-lib-unreviewed-3)
    (in-library song-lib-unreviewed-4)
    (in-library song-lib-unreviewed-5)
    (in-library song-lib-reviewed-1)
    (in-library song-lib-reviewed-2)
    (unreviewed song-lib-unreviewed-1)
    (unreviewed song-lib-unreviewed-2)
    (unreviewed song-lib-unreviewed-3)
    (unreviewed song-lib-unreviewed-4)
    (unreviewed song-lib-unreviewed-5)
    (has-review song-lib-reviewed-1 review-of-song-lib-reviewed-1)
    (has-review song-lib-reviewed-2 review-of-song-lib-reviewed-2))
  (:goal (and
    (rated-one song-lib-unreviewed-1)
    (rated-one song-lib-unreviewed-2)
    (rated-one song-lib-unreviewed-3)
    (rated-one song-lib-unreviewed-4)
    (rated-one song-lib-unreviewed-5)
    (rated-one song-lib-reviewed-1)
    (rated-one song-lib-reviewed-2)
    (task-completed))))
