(define (domain appworld-5a83b05-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory substring file - object)
  (:constants file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory)
    (is-pdf ?f - file)
    (listed ?d - directory)
    (deleted ?f - file)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory ?s - substring)
    :precondition (and (has-token file-system ?t)
                       (not (listed ?d))
                       (not (task-completed)))
    :effect (listed ?d))

  ; API: file_system.delete_file
  (:action file-system-delete-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (in-directory ?f ?d)
                       (listed ?d)
                       (is-pdf ?f)
                       (not (deleted ?f))
                       (not (task-completed)))
    :effect (deleted ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - file ?f2 - file)
    :precondition (and (deleted ?f1)
                       (deleted ?f2)
                       (not (= ?f1 ?f2))
                       (not (task-completed)))
    :effect (task-completed))
)
