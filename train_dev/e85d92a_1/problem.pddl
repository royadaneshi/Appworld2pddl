(define (problem task-e85d92a-1)
  (:domain appworld-e85d92a-1)
  (:objects
    valerie - person
    velvet-echo - artist
    velvet-echo-top-song - song
    query-velvet-echo - query
    sort-minus-play-count - sort-key
  )
  (:init
    (query-for query-velvet-echo velvet-echo)
    (sort-most-played sort-minus-play-count)
    (song-by velvet-echo-top-song velvet-echo)
  )
  (:goal (and
    (found-most-played velvet-echo-top-song velvet-echo)
    (task-completed)
  ))
)
