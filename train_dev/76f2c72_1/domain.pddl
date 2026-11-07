(define (domain appworld-76f2c72-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token amount entry - object
    directory file - entry)
  (:constants file-system phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (bills-directory ?d - directory)
    (next-entry ?prev - entry ?f - file)
    (last-bill ?f - file)
    (total-of-bills ?amt - amount)
    (inspected ?e - entry)
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
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (bills-directory ?d))
    :effect (and (inspected ?d)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?prev - entry)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (next-entry ?prev ?f) (inspected ?prev))
    :effect (and (inspected ?f)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount ?last - file)
    :precondition (and (not (task-completed)) (current-date-known) (total-of-bills ?amt) (last-bill ?last) (inspected ?last))
    :effect (and (task-completed)))
)
