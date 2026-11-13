(define (domain appworld-8ce6779-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token email flag project task-item person message - object)
  (:constants
    supervisor todoist - app
    task-1 task-2 task-3 task-4 - task-item
    volunteer-1 volunteer-2 volunteer-3 volunteer-4 - person
    thanks-volunteer-1 thanks-volunteer-2 thanks-volunteer-3 thanks-volunteer-4 - message
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (known-id ?p - project)
    (task-in-project ?k - task-item ?p - project)
    (assigned-to-me ?k - task-item)
    (incomplete ?k - task-item)
    (tasks-listed ?p - project)
    (volunteer ?k - task-item ?v - person)
    (found-volunteer ?k - task-item ?v - person)
    (person-email ?v - person ?e - email)
    (thanks-message ?v - person ?m - message)
    (reassigned ?k - task-item ?v - person)
    (comment-posted ?k - task-item ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)) (not (task-completed)))
    :effect (has-token todoist ?t))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token ?p - project)
    :precondition (and (has-token todoist ?t) (not (task-completed)))
    :effect (known-id ?p))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?p - project ?t - token ?me - email ?f - flag)
    :precondition (and (has-token todoist ?t) (known-id ?p) (supervisor-email ?me) (not (task-completed)))
    :effect (tasks-listed ?p))

  ; API: todoist.show_task_comments
  (:action todoist-show-task-comments
    :parameters (?k - task-item ?t - token ?p - project ?v - person)
    :precondition (and (has-token todoist ?t) (task-in-project ?k ?p) (tasks-listed ?p) (assigned-to-me ?k) (incomplete ?k) (volunteer ?k ?v) (not (task-completed)))
    :effect (found-volunteer ?k ?v))

  ; API: todoist.assign_or_unassign_task
  (:action todoist-assign-or-unassign-task
    :parameters (?k - task-item ?t - token ?e - email ?v - person)
    :precondition (and (has-token todoist ?t) (found-volunteer ?k ?v) (person-email ?v ?e) (not (task-completed)))
    :effect (reassigned ?k ?v))

  ; API: todoist.post_task_comment
  (:action todoist-post-task-comment
    :parameters (?k - task-item ?m - message ?t - token ?v - person)
    :precondition (and (has-token todoist ?t) (reassigned ?k ?v) (thanks-message ?v ?m) (not (task-completed)))
    :effect (comment-posted ?k ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (reassigned task-1 volunteer-1)
      (comment-posted task-1 thanks-volunteer-1)
      (reassigned task-2 volunteer-2)
      (comment-posted task-2 thanks-volunteer-2)
      (reassigned task-3 volunteer-3)
      (comment-posted task-3 thanks-volunteer-3)
      (reassigned task-4 volunteer-4)
      (comment-posted task-4 thanks-volunteer-4)
      (not (task-completed)))
    :effect (task-completed)))
