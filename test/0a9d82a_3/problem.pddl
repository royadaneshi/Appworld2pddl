(define (problem task-0a9d82a-3)
  (:domain appworld-0a9d82a-3)
  (:objects
    angelica - person
    angelica-wils-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit - query
    habit-log-note-1 habit-log-note-2 - note
    longest-streak-days - streak-count)
  (:init
    (password-for simple-note simple-note-password)
    (habit-query query-habit)
    (habit-note habit-log-note-1)
    (habit-note habit-log-note-2)
    (answer-from-logs longest-streak-days habit-log-note-1 habit-log-note-2))
  (:goal (and
    (note-read habit-log-note-1)
    (note-read habit-log-note-2)
    (task-completed))))
