(define (problem task-d6ac34d-3)
  (:domain appworld-d6ac34d-3)
  (:objects
    marcus - person
    ma-smith-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-habit-tracking - query
    yesterday-habit-note today-habit-note - note
    title-habit-log-2023-05-18 - title
    content-habit-log-2023-05-18-home-prepared-meals - content
    tags-habit-log - tag-list
    pinned-as-yesterday - pinned-flag
  )
  (:init
    (username-for simple-note ma-smith-at-gmail-com)
    (password-for simple-note simple-note-password)
    (query-matches query-habit-tracking yesterday-habit-note)
    (today-version yesterday-habit-note title-habit-log-2023-05-18 content-habit-log-2023-05-18-home-prepared-meals tags-habit-log pinned-as-yesterday)
  )
  (:goal (and (note-created today-habit-note) (task-completed)))
)
