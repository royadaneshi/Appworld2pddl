(define (problem task-d6ac34d-2)
  (:domain appworld-d6ac34d-2)
  (:objects
    sabrina - person
    sab-brown-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit - query
    habit-log-yesterday - note
    habit-log-today - note
    title-habit-log-today - title
    content-today-did-not-meditate - content
    tags-of-yesterday-log - tags
    pinned-of-yesterday-log - pinned-flag)
  (:init
    (password-for simple-note simple-note-password)
    (query-finds query-habit habit-log-yesterday)
    (title-for-today title-habit-log-today habit-log-yesterday)
    (content-for-today content-today-did-not-meditate habit-log-yesterday)
    (tags-of tags-of-yesterday-log habit-log-yesterday)
    (pinned-of pinned-of-yesterday-log habit-log-yesterday))
  (:goal (and
    (note-created habit-log-today)
    (note-has-title habit-log-today title-habit-log-today)
    (note-has-content habit-log-today content-today-did-not-meditate)
    (note-has-tags habit-log-today tags-of-yesterday-log)
    (note-has-pinned habit-log-today pinned-of-yesterday-log)
    (task-completed)))
)
