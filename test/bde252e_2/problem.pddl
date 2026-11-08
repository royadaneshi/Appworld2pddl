(define (problem task-bde252e-2)
  (:domain appworld-bde252e-2)
  (:objects
    jordan - person
    jo-harr-at-gmail-com - username
    simple-note-password todoist-password - password
    simple-note-token todoist-token - token
    query-schedule - query
    work-schedule-note - note
    inbox todays-target - project
    goal-task-done goal-task-leftover inbox-task-fits inbox-task-overflow - task-item
    inbox-task-fits-title - title
    inbox-task-fits-description - description
    inbox-task-fits-duration - duration
    inbox-task-fits-duration-unit - duration-unit
    inbox-task-fits-priority - priority)
  (:init
    (password-for simple-note simple-note-password)
    (password-for todoist todoist-password)
    (note-query query-schedule work-schedule-note)
    (schedule-note work-schedule-note)
    (inbox-project inbox)
    (goal-project todays-target)
    ; Today's Target: one completed task (to delete) and one incomplete leftover (keep; it consumes schedule time first)
    (in-project goal-task-done todays-target)
    (in-project goal-task-leftover todays-target)
    (outstanding goal-task-leftover)
    ; Inbox: one incomplete task that fits the remaining schedule (to move) and one that does not (keep)
    (in-project inbox-task-fits inbox)
    (outstanding inbox-task-fits)
    (fits-schedule inbox-task-fits)
    (task-title inbox-task-fits inbox-task-fits-title)
    (task-description inbox-task-fits inbox-task-fits-description)
    (task-duration inbox-task-fits inbox-task-fits-duration)
    (task-duration-unit inbox-task-fits inbox-task-fits-duration-unit)
    (task-priority inbox-task-fits inbox-task-fits-priority)
    (in-project inbox-task-overflow inbox)
    (outstanding inbox-task-overflow))
  (:goal (and (deleted goal-task-done)
              (copied inbox-task-fits)
              (deleted inbox-task-fits)
              (task-completed))))
