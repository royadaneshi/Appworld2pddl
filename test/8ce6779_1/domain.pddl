(define (domain appworld-8ce6779-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token email flag project task-item comment-text - object)
  (:constants supervisor todoist - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (is-false ?f - flag)
    (projects-listed)
    (in-project ?task - task-item ?proj - project)
    (tasks-listed ?proj - project)
    (comments-checked ?task - task-item)
    (volunteer-for ?task - task-item ?p - person)
    (person-email ?p - person ?e - email)
    (thank-you-text ?p - person ?c - comment-text)
    (reassigned ?task - task-item ?p - person)
    (commented ?task - task-item ?c - comment-text)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action todoist-login
    ; API: todoist.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for todoist ?u) (password-for todoist ?pw) (not (has-token todoist ?t)))
    :effect (has-token todoist ?t))

  (:action todoist-show-projects
    ; API: todoist.show_projects
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token todoist ?t))
    :effect (projects-listed))

  (:action todoist-show-tasks
    ; API: todoist.show_tasks
    :parameters (?proj - project ?t - token ?me - email ?done - flag)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (projects-listed) (supervisor-email ?me) (is-false ?done))
    :effect (tasks-listed ?proj))

  (:action todoist-show-task-comments
    ; API: todoist.show_task_comments
    :parameters (?task - task-item ?t - token ?proj - project)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (in-project ?task ?proj) (tasks-listed ?proj))
    :effect (comments-checked ?task))

  (:action todoist-assign-or-unassign-task
    ; API: todoist.assign_or_unassign_task
    :parameters (?task - task-item ?t - token ?e - email ?p - person)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (comments-checked ?task) (volunteer-for ?task ?p) (person-email ?p ?e) (not (reassigned ?task ?p)))
    :effect (reassigned ?task ?p))

  (:action todoist-post-task-comment
    ; API: todoist.post_task_comment
    :parameters (?task - task-item ?c - comment-text ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token todoist ?t) (reassigned ?task ?p) (thank-you-text ?p ?c) (not (commented ?task ?c)))
    :effect (commented ?task ?c))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?t1 ?t2 ?t3 - task-item ?p1 ?p2 - person ?c1 ?c2 - comment-text)
    :precondition (and (not (task-completed))
      (not (= ?t1 ?t2)) (not (= ?t1 ?t3)) (not (= ?t2 ?t3))
      (comments-checked ?t1) (comments-checked ?t2) (comments-checked ?t3)
      (reassigned ?t1 ?p1) (commented ?t1 ?c1)
      (reassigned ?t2 ?p2) (commented ?t2 ?c2))
    :effect (task-completed))
)
