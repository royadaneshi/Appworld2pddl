(define (problem task-e85d92a-3)
  (:domain appworld-e85d92a-3)
  (:objects
    stacy-maldonado - person
    jasper-skye - artist
    query-jasper-skye - query
    sort-by-minus-play-count - sort-key
    most-played-song-of-jasper-skye - song)
  (:init
    (artist-query query-jasper-skye jasper-skye)
    (target-artist jasper-skye)
    (sort-most-played sort-by-minus-play-count))
  (:goal (and (answer-found most-played-song-of-jasper-skye) (task-completed))))
