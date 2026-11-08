(define (domain appworld-8ce6779-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email project task-item comment-text flag - object)
  (:constants supervisor todoist - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-supervisor ?p - person)
    (person-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (known-id ?pj - project)
    (task-in-project ?tk - task-item ?pj - project)
    (tasks-listed ?pj - project)
    (comments-read ?tk - task-item)
    (volunteer-for ?tk - task-item ?p - person)
    (no-volunteer ?tk - task-item)
    (thank-you-text ?p - person ?c - comment-text)
    (reassigned ?tk - task-item ?p - person)
    (commented ?tk - task-item ?c - comment-text)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?me - person ?e - email)
    :precondition (and (not (task-completed)) (is-supervisor ?me) (person-email ?me ?e))
    :effect (known-email ?me ?e))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)))
    :effect (has-token todoist ?t))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token ?pj - project)
    :precondition (and (not (task-completed)) (has-token todoist ?t))
    :effect (known-id ?pj))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?pj - project ?t - token ?ae - email ?f - flag ?me - person)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (known-id ?pj) (is-supervisor ?me) (known-email ?me ?ae))
    :effect (tasks-listed ?pj))

  ; API: todoist.show_task_comments
  (:action todoist-show-task-comments
    :parameters (?tk - task-item ?t - token ?pj - project)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (task-in-project ?tk ?pj) (tasks-listed ?pj))
    :effect (comments-read ?tk))

  ; API: todoist.assign_or_unassign_task
  (:action todoist-assign-or-unassign-task
    :parameters (?tk - task-item ?t - token ?ae - email ?p - person)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (comments-read ?tk) (volunteer-for ?tk ?p) (person-email ?p ?ae) (not (reassigned ?tk ?p)))
    :effect (reassigned ?tk ?p))

  ; API: todoist.post_task_comment
  (:action todoist-post-task-comment
    :parameters (?tk - task-item ?c - comment-text ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (reassigned ?tk ?p) (thank-you-text ?p ?c) (not (commented ?tk ?c)))
    :effect (commented ?tk ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tk1 ?tk2 ?tk3 - task-item ?p1 ?p2 - person ?c1 ?c2 - comment-text)
    :precondition (and (not (task-completed))
      (not (= ?tk1 ?tk2)) (not (= ?tk1 ?tk3)) (not (= ?tk2 ?tk3))
      (comments-read ?tk1) (comments-read ?tk2) (comments-read ?tk3)
      (reassigned ?tk1 ?p1) (commented ?tk1 ?c1)
      (reassigned ?tk2 ?p2) (commented ?tk2 ?c2)
      (no-volunteer ?tk3))
    :effect (task-completed))
)
