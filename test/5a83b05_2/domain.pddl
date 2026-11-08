(define (domain appworld-5a83b05-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token dirpath filepath substring - object)
  (:constants file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (jpg-filter ?s - substring)
    (in-directory ?f - filepath ?d - dirpath)
    (is-jpg ?f - filepath)
    (directory-listed ?d - dirpath)
    (deleted ?f - filepath)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath ?s - substring)
    :precondition (and (has-token file-system ?t) (jpg-filter ?s) (not (task-completed)))
    :effect (directory-listed ?d))

  ; API: file_system.delete_file
  (:action file-system-delete-file
    :parameters (?f - filepath ?t - token ?d - dirpath)
    :precondition (and (has-token file-system ?t) (directory-listed ?d) (in-directory ?f ?d) (is-jpg ?f) (not (deleted ?f)) (not (task-completed)))
    :effect (deleted ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - filepath ?f2 - filepath)
    :precondition (and (deleted ?f1) (deleted ?f2) (not (= ?f1 ?f2)) (not (task-completed)))
    :effect (task-completed)))
