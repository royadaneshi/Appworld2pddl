(define (domain appworld-76f2c72-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory file amount - object)
  (:constants file-system phone - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-year-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory)
    (directory-listed ?d - directory)
    (amount-found ?f - file)
    (adds-to ?f - file ?before - amount ?after - amount)
    (running-total ?a - amount)
    (final-total ?a - amount)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-year-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known)
                       (passwords-known)
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (not (task-completed)))
    :effect (and (directory-listed ?d)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory ?before - amount ?after - amount)
    :precondition (and (has-token file-system ?t)
                       (in-directory ?f ?d)
                       (directory-listed ?d)
                       (current-year-known)
                       (not (amount-found ?f))
                       (running-total ?before)
                       (adds-to ?f ?before ?after)
                       (not (task-completed)))
    :effect (and (amount-found ?f)
                 (not (running-total ?before))
                 (running-total ?after)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (running-total ?answer)
                       (final-total ?answer)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
