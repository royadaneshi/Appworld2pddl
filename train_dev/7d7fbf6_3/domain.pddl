(define (domain appworld-7d7fbf6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token directory zipfile flag - object)
  (:constants
    file-system - app
    vacation-dir-1 vacation-dir-2 vacation-dir-3 - directory
    vacation-zip-1 vacation-zip-2 vacation-zip-3 - zipfile)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (vacations-root ?d - directory)
    (subdirectory-of ?root - directory ?d - directory)
    (directory-listed ?d - directory)
    (zip-target ?d - directory ?z - zipfile)
    (is-true ?f - flag)
    (is-false ?f - flag)
    (compressed ?d - directory ?z - zipfile)
    (directory-deleted ?d - directory)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory ?r - flag)
    :precondition (and (has-token file-system ?t)
                       (vacations-root ?d)
                       (is-false ?r)
                       (not (task-completed)))
    :effect (and (directory-listed ?d)))

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory ?t - token ?z - zipfile ?del - flag ?ow - flag ?root - directory)
    :precondition (and (has-token file-system ?t)
                       (directory-listed ?root)
                       (subdirectory-of ?root ?d)
                       (zip-target ?d ?z)
                       (is-true ?del)
                       (is-true ?ow)
                       (not (directory-deleted ?d))
                       (not (task-completed)))
    :effect (and (compressed ?d ?z) (directory-deleted ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (compressed vacation-dir-1 vacation-zip-1) (directory-deleted vacation-dir-1)
                       (compressed vacation-dir-2 vacation-zip-2) (directory-deleted vacation-dir-2)
                       (compressed vacation-dir-3 vacation-zip-3) (directory-deleted vacation-dir-3)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
