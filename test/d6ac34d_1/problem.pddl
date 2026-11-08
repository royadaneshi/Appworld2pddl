(define (problem task-d6ac34d-1)
  (:domain appworld-d6ac34d-1)
  (:objects
    anita - person
    anita-burch-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit - query
    yesterday-habit-log today-habit-log - note
    title-today - title
    content-today - content
    habit-tags - taglist
    pinned-as-yesterday - pinflag)
  (:init
    (password-for simple-note simple-note-password)
    (matches-query yesterday-habit-log query-habit)
    (previous-log today-habit-log yesterday-habit-log)
    (derived-title yesterday-habit-log title-today)
    (derived-content yesterday-habit-log content-today)
    (note-tags yesterday-habit-log habit-tags)
    (note-pinned yesterday-habit-log pinned-as-yesterday))
  (:goal (and (habit-log-added-for-today) (task-completed))))
