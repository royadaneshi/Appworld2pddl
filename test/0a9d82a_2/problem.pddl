(define (problem task-0a9d82a-2)
  (:domain appworld-0a9d82a-2)
  (:objects
    kyle-moore - person
    kyl-moor-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit - query
    habit-log-note-1 habit-log-note-2 - note
    limited-screen-time-to-1-hr - habit
    longest-streak-days - streak-days)
  (:init
    (password-for simple-note simple-note-password)
    (found-by query-habit habit-log-note-1)
    (found-by query-habit habit-log-note-2)
    (habit-log habit-log-note-1 limited-screen-time-to-1-hr)
    (habit-log habit-log-note-2 limited-screen-time-to-1-hr))
  (:goal (and
    (note-read habit-log-note-1)
    (note-read habit-log-note-2)
    (streak-known limited-screen-time-to-1-hr longest-streak-days)
    (task-completed)))
)
