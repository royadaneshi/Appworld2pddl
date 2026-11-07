(define (domain appworld-34d9492-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token directory-path file-path month vacation-spot person - object)
  (:constants
    file-system phone - app
    rome santorini berlin - vacation-spot)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (file-in-directory ?f - file-path ?d - directory-path)
    (directory-listed ?d - directory-path)
    (created-in ?f - file-path ?m - month)
    (known-created-in ?f - file-path ?m - month)
    (month-spot ?m - month ?s - vacation-spot)
    (target-path ?f - file-path ?s - vacation-spot ?dst - file-path)
    (moved ?src - file-path ?dst - file-path)
    (organized ?f - file-path)
    (spot-organized ?s - vacation-spot)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (directory-listed ?d))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token ?d - directory-path ?m - month)
    :precondition (and (has-token file-system ?t) (directory-listed ?d) (file-in-directory ?f ?d) (created-in ?f ?m) (current-date-known) (not (task-completed)))
    :effect (known-created-in ?f ?m))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - file-path ?dst - file-path ?t - token ?m - month ?s - vacation-spot)
    :precondition (and (has-token file-system ?t) (known-created-in ?src ?m) (month-spot ?m ?s) (target-path ?src ?s ?dst) (not (organized ?src)) (not (task-completed)))
    :effect (and (moved ?src ?dst) (organized ?src) (spot-organized ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (spot-organized rome) (spot-organized santorini) (spot-organized berlin) (not (task-completed)))
    :effect (task-completed)))
