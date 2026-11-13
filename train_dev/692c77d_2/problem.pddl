(define (problem task-692c77d-2)
  (:domain appworld-692c77d-2)
  (:objects
    brenda - person
    brenda-webe-at-gmail-com - email
    spotify-password - password
    spotify-token - token
    rating-1 - rating
    song-31 song-173 song-202 song-304 song-310 song-12 song-247 - song
    review-of-song-12 review-of-song-247 - review
  )
  (:init
    (password-for spotify spotify-password)
    (supervisor-email brenda-webe-at-gmail-com)
    (target-rating rating-1)
    (in-library song-31)
    (in-library song-173)
    (in-library song-202)
    (in-library song-304)
    (in-library song-310)
    (in-library song-12)
    (in-library song-247)
    (unreviewed song-31)
    (unreviewed song-173)
    (unreviewed song-202)
    (unreviewed song-304)
    (unreviewed song-310)
    (has-review song-12 review-of-song-12)
    (has-review song-247 review-of-song-247))
  (:goal (and
    (rated-one song-31)
    (rated-one song-173)
    (rated-one song-202)
    (rated-one song-304)
    (rated-one song-310)
    (rated-one song-12)
    (rated-one song-247)
    (task-completed))))
