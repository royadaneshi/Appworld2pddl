(define (problem task-e85d92a-2)
  (:domain appworld-e85d92a-2)
  (:objects
    connor-brown - person
    zoey-james - artist
    query-zoey-james - query
    sort-by-plus-play-count - sort-key
    zoey-james-least-played-song - song)
  (:init
    (query-for zoey-james query-zoey-james)
    (sort-ascending-play-count sort-by-plus-play-count)
    (least-played-song-of zoey-james zoey-james-least-played-song))
  (:goal (and (found-title zoey-james-least-played-song) (task-completed)))
)
