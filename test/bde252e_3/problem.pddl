(define (problem task-bde252e-3)
  (:domain appworld-bde252e-3)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    simple-note-password todoist-password - password
    simple-note-token todoist-token - token
    query-schedule - query
    work-schedule-note - note
    today-project inbox-project - project
    today-done-task today-leftover-task inbox-fitting-task inbox-overflow-task - task-item
    title-of-inbox-fitting-task - title
    description-of-inbox-fitting-task - description
    duration-of-inbox-fitting-task - duration
    unit-of-inbox-fitting-task - duration-unit
    priority-of-inbox-fitting-task - priority)
  (:init
    (username-for simple-note as-moore-at-gmail-com)
    (username-for todoist as-moore-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for todoist todoist-password)
    (matches-query work-schedule-note query-schedule)
    (is-today today-project)
    (is-inbox inbox-project)
    (in-project today-done-task today-project)
    (in-project today-leftover-task today-project)
    (in-project inbox-fitting-task inbox-project)
    (in-project inbox-overflow-task inbox-project)
    (completed today-done-task)
    (to-delete today-done-task)
    (fits-in-schedule inbox-fitting-task)
    (task-title inbox-fitting-task title-of-inbox-fitting-task)
    (task-description inbox-fitting-task description-of-inbox-fitting-task)
    (task-duration inbox-fitting-task duration-of-inbox-fitting-task)
    (task-duration-unit inbox-fitting-task unit-of-inbox-fitting-task)
    (task-priority inbox-fitting-task priority-of-inbox-fitting-task))
  (:goal (and (deleted today-done-task)
              (copied-to inbox-fitting-task today-project)
              (deleted inbox-fitting-task)
              (task-completed)))
)
