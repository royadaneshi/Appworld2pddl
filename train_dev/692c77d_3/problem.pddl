(define (problem task-692c77d-3)
  (:domain appworld-692c77d-3)
  (:objects
    jessica - person
    jes-mill-at-gmail-com - email
    spotify-password - password
    spotify-token - token
    song-lib-liked-reviewed song-lib-liked-unreviewed song-lib-not-liked song-liked-not-in-lib - song
    review-existing-lower - review
    rating-4 - rating)
  (:init
    (is-supervisor jessica)
    (has-email jessica jes-mill-at-gmail-com)
    (password-for spotify spotify-password)
    (target-rating rating-4)
    (in-album-library song-lib-liked-reviewed)
    (in-album-library song-lib-liked-unreviewed)
    (in-album-library song-lib-not-liked)
    (liked song-lib-liked-reviewed)
    (liked song-lib-liked-unreviewed)
    (liked song-liked-not-in-lib)
    (song-reviewed song-lib-liked-reviewed)
    (has-review song-lib-liked-reviewed review-existing-lower))
  (:goal (and
    (song-rated song-lib-liked-reviewed rating-4)
    (song-rated song-lib-liked-unreviewed rating-4)
    (task-completed))))
