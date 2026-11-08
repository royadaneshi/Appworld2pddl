(define (domain appworld-29a7b7e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app - object
    person - object
    username - object
    password - object
    token - object
    dirpath - object
    filepath - object
    file - object)
  (:constants supervisor file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (meetings-directory ?d - dirpath)
    (directory-listed ?d - dirpath)
    (subdirectory-of ?d - dirpath ?parent - dirpath)
    (directory-exists ?d - dirpath)
    (old-path ?f - file ?p - filepath)
    (new-path ?f - file ?p - filepath)
    (new-dir ?f - file ?d - dirpath)
    (file-moved ?f - file)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath)
    :precondition (and (has-token file-system ?t)
                       (meetings-directory ?d)
                       (not (task-completed)))
    :effect (and (directory-listed ?d)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dirpath ?t - token ?parent - dirpath)
    :precondition (and (has-token file-system ?t)
                       (subdirectory-of ?d ?parent)
                       (directory-listed ?parent)
                       (not (directory-exists ?d))
                       (not (task-completed)))
    :effect (and (directory-exists ?d)))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?f - file ?d - dirpath)
    :precondition (and (has-token file-system ?t)
                       (old-path ?f ?src)
                       (new-path ?f ?dst)
                       (new-dir ?f ?d)
                       (directory-exists ?d)
                       (not (file-moved ?f))
                       (not (task-completed)))
    :effect (and (file-moved ?f)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - file)
    :precondition (and (file-moved ?f)
                       (not (task-completed)))
    :effect (and (task-completed))))
