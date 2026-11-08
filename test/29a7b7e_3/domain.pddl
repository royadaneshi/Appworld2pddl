(define (domain appworld-29a7b7e-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token dirpath filepath meeting-file - object)
  (:constants file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (meetings-directory ?d - dirpath)
    (meeting-files-listed)
    (source-path ?f - meeting-file ?p - filepath)
    (target-path ?f - meeting-file ?p - filepath)
    (target-directory ?f - meeting-file ?d - dirpath)
    (target-subdirectory ?d - dirpath)
    (directory-exists ?d - dirpath)
    (moved ?f - meeting-file)
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
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath)
    :precondition (and (has-token file-system ?t)
                       (meetings-directory ?d)
                       (directory-exists ?d)
                       (not (task-completed)))
    :effect (and (meeting-files-listed)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dirpath ?t - token)
    :precondition (and (has-token file-system ?t)
                       (meeting-files-listed)
                       (target-subdirectory ?d)
                       (not (directory-exists ?d))
                       (not (task-completed)))
    :effect (and (directory-exists ?d)))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?f - meeting-file ?d - dirpath)
    :precondition (and (has-token file-system ?t)
                       (meeting-files-listed)
                       (source-path ?f ?src)
                       (target-path ?f ?dst)
                       (target-directory ?f ?d)
                       (directory-exists ?d)
                       (not (moved ?f))
                       (not (task-completed)))
    :effect (and (moved ?f)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - meeting-file ?f2 - meeting-file ?f3 - meeting-file)
    :precondition (and (moved ?f1) (moved ?f2) (moved ?f3)
                       (not (= ?f1 ?f2)) (not (= ?f1 ?f3)) (not (= ?f2 ?f3))
                       (not (task-completed)))
    :effect (and (task-completed)))
)
