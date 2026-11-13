(define (domain appworld-bde252e-2)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person project task-item note
    username password token query
    title description duration duration-unit priority - object)
  (:constants simple-note todoist - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-query ?q - query ?n - note)
    (schedule-note ?n - note)
    (known-id ?n - note)
    (schedule-known)
    (projects-known)
    (inbox-project ?p - project)
    (goal-project ?p - project)
    (tasks-known ?p - project)
    (in-project ?k - task-item ?p - project)
    (outstanding ?k - task-item)
    (fits-schedule ?k - task-item)
    (task-title ?k - task-item ?ti - title)
    (task-description ?k - task-item ?d - description)
    (task-duration ?k - task-item ?du - duration)
    (task-duration-unit ?k - task-item ?un - duration-unit)
    (task-priority ?k - task-item ?pr - priority)
    (copied ?k - task-item)
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
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (schedule-note ?n) (not (task-completed)))
    :effect (schedule-known))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app todoist ?t) (credential-of-app todoist ?pw) (credential-of-app todoist ?u) (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)) (not (task-completed)))
    :effect (has-token todoist ?t))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token)
    :precondition (and (has-token todoist ?t) (not (task-completed)))
    :effect (projects-known))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?p - project ?t - token)
    :precondition (and (has-token todoist ?t) (projects-known) (not (task-completed)))
    :effect (tasks-known ?p))

  ; API: todoist.delete_task
  ; a task may be deleted only when it is not outstanding, i.e. it is a completed
  ; Today's Target task or an Inbox task whose identical copy has already been created
  (:action todoist-delete-task
    :parameters (?k - task-item ?t - token ?p - project)
    :precondition (and (has-token todoist ?t) (in-project ?k ?p) (tasks-known ?p) (not (outstanding ?k)) (not (deleted ?k)) (not (task-completed)))
    :effect (deleted ?k))

  ; API: todoist.create_task
  ; creates an identical copy of a schedule-fitting Inbox task inside Today's Target
  (:action todoist-create-task
    :parameters (?p - project ?ti - title ?t - token ?d - description ?du - duration ?un - duration-unit ?pr - priority ?k - task-item ?src - project)
    :precondition (and (has-token todoist ?t) (goal-project ?p) (inbox-project ?src) (tasks-known ?p) (tasks-known ?src) (schedule-known) (in-project ?k ?src) (fits-schedule ?k) (not (copied ?k)) (not (deleted ?k)) (task-title ?k ?ti) (task-description ?k ?d) (task-duration ?k ?du) (task-duration-unit ?k ?un) (task-priority ?k ?pr) (not (task-completed)))
    :effect (and (copied ?k) (not (outstanding ?k))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?i - task-item) (imply (fits-schedule ?i) (and (copied ?i) (deleted ?i)))) (not (task-completed)))
    :effect (task-completed))

)
