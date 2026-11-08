(define (domain appworld-bde252e-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person record - object
    note project task-item - record
    username password token query title description duration duration-unit priority - object)
  (:constants simple-note todoist - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?r - record)
    (matches-query ?n - note ?q - query)
    (schedule-known)
    (projects-known)
    (is-today ?p - project)
    (is-inbox ?p - project)
    (tasks-listed ?p - project)
    (in-project ?k - task-item ?p - project)
    (completed ?k - task-item)
    (fits-in-schedule ?k - task-item)
    (task-title ?k - task-item ?x - title)
    (task-description ?k - task-item ?x - description)
    (task-duration ?k - task-item ?x - duration)
    (task-duration-unit ?k - task-item ?x - duration-unit)
    (task-priority ?k - task-item ?x - priority)
    (to-delete ?k - task-item)
    (copied-to ?k - task-item ?p - project)
    (deleted ?k - task-item)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (passwords-known)
                       (username-for simple-note ?u)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed))
                       (has-token simple-note ?t)
                       (matches-query ?n ?q))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed))
                       (has-token simple-note ?t)
                       (known-id ?n))
    :effect (schedule-known))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (passwords-known)
                       (username-for todoist ?u)
                       (password-for todoist ?pw)
                       (not (has-token todoist ?t)))
    :effect (has-token todoist ?t))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token todoist ?t))
    :effect (projects-known))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?p - project ?t - token)
    :precondition (and (not (task-completed))
                       (has-token todoist ?t)
                       (projects-known))
    :effect (tasks-listed ?p))

  ; API: todoist.delete_task
  (:action todoist-delete-task
    :parameters (?k - task-item ?t - token ?p - project)
    :precondition (and (not (task-completed))
                       (has-token todoist ?t)
                       (in-project ?k ?p)
                       (tasks-listed ?p)
                       (to-delete ?k)
                       (not (deleted ?k)))
    :effect (deleted ?k))

  ; API: todoist.create_task
  (:action todoist-create-task
    :parameters (?p - project ?title - title ?t - token ?desc - description ?dur - duration ?unit - duration-unit ?prio - priority ?src - task-item ?srcp - project)
    :precondition (and (not (task-completed))
                       (has-token todoist ?t)
                       (is-today ?p)
                       (is-inbox ?srcp)
                       (schedule-known)
                       (tasks-listed ?p)
                       (tasks-listed ?srcp)
                       (in-project ?src ?srcp)
                       (fits-in-schedule ?src)
                       (not (deleted ?src))
                       (task-title ?src ?title)
                       (task-description ?src ?desc)
                       (task-duration ?src ?dur)
                       (task-duration-unit ?src ?unit)
                       (task-priority ?src ?prio)
                       (not (copied-to ?src ?p)))
    :effect (and (copied-to ?src ?p)
                 (to-delete ?src)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?done - task-item ?moved - task-item ?p - project)
    :precondition (and (not (task-completed))
                       (completed ?done)
                       (deleted ?done)
                       (is-today ?p)
                       (fits-in-schedule ?moved)
                       (copied-to ?moved ?p)
                       (deleted ?moved))
    :effect (task-completed))
)
