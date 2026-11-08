(define (problem task-bde252e-1)
  (:domain appworld-bde252e-1)
  (:objects
    dillon-wilson - person
    diwils-at-gmail-com - username
    simple-note-password todoist-password - password
    simple-note-token todoist-token - token
    query-schedule query-inbox query-todays-goal - query
    work-schedule-note - note
    project-inbox project-todays-goal - project
    goal-task-done-1 goal-task-left-1 - goal-task
    inbox-task-1 inbox-task-2 inbox-task-3 - inbox-task
    inbox-task-1-title inbox-task-2-title inbox-task-3-title - title
    inbox-task-1-description inbox-task-2-description inbox-task-3-description - description
    inbox-task-1-due-date inbox-task-2-due-date inbox-task-3-due-date - date
    inbox-task-1-duration inbox-task-2-duration inbox-task-3-duration - duration
    inbox-task-1-duration-unit inbox-task-2-duration-unit inbox-task-3-duration-unit - duration-unit
    inbox-task-1-priority inbox-task-2-priority inbox-task-3-priority - priority)
  (:init
    (password-for simple-note simple-note-password)
    (password-for todoist todoist-password)
    (note-query work-schedule-note query-schedule)
    (schedule-note work-schedule-note)
    (project-query project-inbox query-inbox)
    (project-query project-todays-goal query-todays-goal)
    (inbox-project project-inbox)
    (goal-project project-todays-goal)
    (task-in-project goal-task-done-1 project-todays-goal)
    (task-in-project goal-task-left-1 project-todays-goal)
    (task-in-project inbox-task-1 project-inbox)
    (task-in-project inbox-task-2 project-inbox)
    (task-in-project inbox-task-3 project-inbox)
    (removable goal-task-done-1)
    (fits-schedule inbox-task-1)
    (fits-schedule inbox-task-2)
    (task-title inbox-task-1 inbox-task-1-title)
    (task-description inbox-task-1 inbox-task-1-description)
    (task-due-date inbox-task-1 inbox-task-1-due-date)
    (task-duration inbox-task-1 inbox-task-1-duration)
    (task-duration-unit inbox-task-1 inbox-task-1-duration-unit)
    (task-priority inbox-task-1 inbox-task-1-priority)
    (task-title inbox-task-2 inbox-task-2-title)
    (task-description inbox-task-2 inbox-task-2-description)
    (task-due-date inbox-task-2 inbox-task-2-due-date)
    (task-duration inbox-task-2 inbox-task-2-duration)
    (task-duration-unit inbox-task-2 inbox-task-2-duration-unit)
    (task-priority inbox-task-2 inbox-task-2-priority)
    (task-title inbox-task-3 inbox-task-3-title)
    (task-description inbox-task-3 inbox-task-3-description)
    (task-due-date inbox-task-3 inbox-task-3-due-date)
    (task-duration inbox-task-3 inbox-task-3-duration)
    (task-duration-unit inbox-task-3 inbox-task-3-duration-unit)
    (task-priority inbox-task-3 inbox-task-3-priority))
  (:goal (and
    (deleted goal-task-done-1)
    (copied inbox-task-1)
    (deleted inbox-task-1)
    (copied inbox-task-2)
    (deleted inbox-task-2)
    (task-completed))))
