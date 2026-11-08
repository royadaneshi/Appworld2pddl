(define (problem task-0a9d82a-1)
  (:domain appworld-0a9d82a-1)
  (:objects
    stephen - person
    stmcco-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit - query
    habit-log-note-1 habit-log-note-2 - note
    practiced-good-posture - habit
    streak-days - streak)
  (:init
    (username-for simple-note stmcco-at-gmail-com)
    (password-for simple-note simple-note-password)
    (habit-query query-habit)
    (habit-log habit-log-note-1)
    (habit-log habit-log-note-2)
    (target-habit practiced-good-posture)
    (longest-streak-of practiced-good-posture streak-days))
  (:goal (and
    (read-note habit-log-note-1)
    (read-note habit-log-note-2)
    (task-completed))))
