(define (domain appworld-34d9492-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory filepath month - object
  )
  (:constants
    file-system phone supervisor - app
    photo-feb-1 photo-feb-2 photo-feb-3 photo-feb-4 photo-feb-5 photo-feb-6 photo-feb-7 photo-feb-8 photo-feb-9 photo-feb-10 photo-feb-11 photo-feb-12 photo-feb-13 photo-feb-14 photo-feb-15 photo-feb-16 photo-feb-17 photo-feb-18 photo-feb-19 photo-feb-20 photo-feb-21 photo-feb-22 photo-feb-23 photo-feb-24 photo-feb-25 photo-feb-26 photo-feb-27 photo-feb-28 photo-feb-29 photo-feb-30 photo-feb-31 photo-feb-32 photo-feb-33 photo-feb-34 photo-feb-35 photo-feb-36 photo-feb-37 photo-feb-38 photo-feb-39 photo-feb-40 photo-feb-41 photo-feb-42 - filepath
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
    :precondition (and
      (moved photo-feb-1 petra-dir)
      (moved photo-feb-2 amsterdam-dir)
      (moved photo-feb-3 budapest-dir)
      (moved photo-feb-4 amsterdam-dir)
      (moved photo-feb-5 budapest-dir)
      (moved photo-feb-6 petra-dir)
      (moved photo-feb-7 petra-dir)
      (moved photo-feb-8 petra-dir)
      (moved photo-feb-9 budapest-dir)
      (moved photo-feb-10 amsterdam-dir)
      (moved photo-feb-11 amsterdam-dir)
      (moved photo-feb-12 budapest-dir)
      (moved photo-feb-13 budapest-dir)
      (moved photo-feb-14 budapest-dir)
      (moved photo-feb-15 amsterdam-dir)
      (moved photo-feb-16 petra-dir)
      (moved photo-feb-17 petra-dir)
      (moved photo-feb-18 amsterdam-dir)
      (moved photo-feb-19 petra-dir)
      (moved photo-feb-20 petra-dir)
      (moved photo-feb-21 budapest-dir)
      (moved photo-feb-22 budapest-dir)
      (moved photo-feb-23 petra-dir)
      (moved photo-feb-24 petra-dir)
      (moved photo-feb-25 amsterdam-dir)
      (moved photo-feb-26 amsterdam-dir)
      (moved photo-feb-27 petra-dir)
      (moved photo-feb-28 amsterdam-dir)
      (moved photo-feb-29 budapest-dir)
      (moved photo-feb-30 amsterdam-dir)
      (moved photo-feb-31 petra-dir)
      (moved photo-feb-32 budapest-dir)
      (moved photo-feb-33 amsterdam-dir)
      (moved photo-feb-34 budapest-dir)
      (moved photo-feb-35 amsterdam-dir)
      (moved photo-feb-36 budapest-dir)
      (moved photo-feb-37 amsterdam-dir)
      (moved photo-feb-38 amsterdam-dir)
      (moved photo-feb-39 petra-dir)
      (moved photo-feb-40 budapest-dir)
      (moved photo-feb-41 budapest-dir)
      (moved photo-feb-42 budapest-dir)
      (not (task-completed)))
    :effect (task-completed)
  )
)
