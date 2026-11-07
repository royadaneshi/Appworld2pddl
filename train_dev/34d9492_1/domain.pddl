(define (domain appworld-34d9492-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory filepath month - object
  )
  (:constants
    file-system phone supervisor - app
    photo-feb photo-mar photo-other - filepath
    petra-dir budapest-dir amsterdam-dir - directory
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-email ?p - person ?u - username)
    (known-username ?u - username)
    (current-date-known)
    (in-directory ?f - filepath ?d - directory)
    (directory-listed ?d - directory)
    (created-in ?f - filepath ?m - month)
    (known-created-in ?f - filepath ?m - month)
    (month-destination ?m - month ?d - directory)
    (moved-path ?src - filepath ?d - directory ?dst - filepath)
    (moved ?f - filepath ?d - directory)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?p - person ?u - username)
    :precondition (and (supervisor-email ?p ?u) (not (task-completed)))
    :effect (known-username ?u)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (known-username ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (directory-listed ?d)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - filepath ?t - token ?d - directory ?m - month)
    :precondition (and (has-token file-system ?t) (current-date-known) (in-directory ?f ?d) (directory-listed ?d) (created-in ?f ?m) (not (task-completed)))
    :effect (known-created-in ?f ?m)
  )

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?m - month ?d - directory)
    :precondition (and (has-token file-system ?t) (known-created-in ?src ?m) (month-destination ?m ?d) (moved-path ?src ?d ?dst) (not (moved ?src ?d)) (not (task-completed)))
    :effect (moved ?src ?d)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (moved photo-feb petra-dir) (moved photo-mar budapest-dir) (moved photo-other amsterdam-dir) (not (task-completed)))
    :effect (task-completed)
  )
)
