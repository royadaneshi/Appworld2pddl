(define (domain appworld-bde252e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person entity username password token query - object
    note project - entity
    task-item title description date duration duration-unit priority - object
    goal-task inbox-task - task-item)
  (:constants supervisor simple-note todoist - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (note-query ?n - note ?q - query)
    (schedule-note ?n - note)
    (known-schedule)
    (project-query ?p - project ?q - query)
    (goal-project ?p - project)
    (inbox-project ?p - project)
    (tasks-listed ?p - project)
    (task-in-project ?k - task-item ?p - project)
    (task-title ?k - task-item ?x - title)
    (task-description ?k - task-item ?x - description)
    (task-due-date ?k - task-item ?x - date)
    (task-duration ?k - task-item ?x - duration)
    (task-duration-unit ?k - task-item ?x - duration-unit)
    (task-priority ?k - task-item ?x - priority)
    (fits-schedule ?k - task-item)
    (removable ?k - task-item)
    (copied ?k - task-item)
    (deleted ?k - task-item)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  (:action simple-note-login
    ; API: simple_note.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  (:action simple-note-search-notes
    ; API: simple_note.search_notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  (:action simple-note-show-note
    ; API: simple_note.show_note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (schedule-note ?n) (not (task-completed)))
    :effect (and (known-schedule)))

  (:action todoist-login
    ; API: todoist.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)) (not (task-completed)))
    :effect (and (has-token todoist ?t)))

  (:action todoist-show-projects
    ; API: todoist.show_projects
    :parameters (?t - token ?q - query ?p - project)
    :precondition (and (has-token todoist ?t) (project-query ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p)))

  (:action todoist-show-tasks
    ; API: todoist.show_tasks
    :parameters (?p - project ?t - token)
    :precondition (and (has-token todoist ?t) (known-id ?p) (not (task-completed)))
    :effect (and (tasks-listed ?p)))

  (:action todoist-create-task
    ; API: todoist.create_task
    :parameters (?p - project ?title - title ?t - token ?desc - description ?due - date ?dur - duration ?unit - duration-unit ?pr - priority ?src - inbox-task ?inbox - project)
    :precondition (and (has-token todoist ?t) (goal-project ?p) (known-id ?p) (tasks-listed ?p) (inbox-project ?inbox) (tasks-listed ?inbox) (task-in-project ?src ?inbox) (known-schedule) (fits-schedule ?src) (task-title ?src ?title) (task-description ?src ?desc) (task-due-date ?src ?due) (task-duration ?src ?dur) (task-duration-unit ?src ?unit) (task-priority ?src ?pr) (not (copied ?src)) (not (deleted ?src)) (not (task-completed)))
    :effect (and (copied ?src) (removable ?src)))

  (:action todoist-delete-task
    ; API: todoist.delete_task
    :parameters (?k - task-item ?t - token ?p - project)
    :precondition (and (has-token todoist ?t) (task-in-project ?k ?p) (tasks-listed ?p) (removable ?k) (not (deleted ?k)) (not (task-completed)))
    :effect (and (deleted ?k)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?done - goal-task ?m1 - inbox-task ?m2 - inbox-task)
    :precondition (and (deleted ?done) (copied ?m1) (deleted ?m1) (copied ?m2) (deleted ?m2) (not (= ?m1 ?m2)) (not (task-completed)))
    :effect (and (task-completed))))
