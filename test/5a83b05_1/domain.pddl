(define (domain appworld-5a83b05-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory-path substring file-path - object)
  (:constants file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (file-in ?f - file-path ?d - directory-path)
    (has-extension ?f - file-path ?s - substring)
    (directory-listed ?d - directory-path ?s - substring)
    (deleted ?f - file-path)
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
    :parameters (?t - token ?d - directory-path ?s - substring)
    :precondition (and (has-token file-system ?t)
                       (not (task-completed)))
    :effect (directory-listed ?d ?s))

  ; API: file_system.delete_file
  (:action file-system-delete-file
    :parameters (?f - file-path ?t - token ?d - directory-path ?s - substring)
    :precondition (and (has-token file-system ?t)
                       (directory-listed ?d ?s)
                       (file-in ?f ?d)
                       (has-extension ?f ?s)
                       (not (deleted ?f))
                       (not (task-completed)))
    :effect (deleted ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - file-path ?f2 - file-path)
    :precondition (and (deleted ?f1)
                       (deleted ?f2)
                       (not (= ?f1 ?f2))
                       (not (task-completed)))
    :effect (task-completed))
)
