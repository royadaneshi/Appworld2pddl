(define (domain appworld-68ee2c9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory file path year - object)
  (:constants
    file-system phone - app
    file-1 file-2 file-3 file-4 - file)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory)
    (directory-listed ?d - directory)
    (known-creation-date ?f - file)
    (file-year ?f - file ?y - year)
    (current-year ?y - year)
    (destination-dir ?fy - year ?cy - year ?d - directory)
    (path-in-directory ?p - path ?d - directory)
    (prefixed-path ?p - path ?f - file)
    (moved ?f - file)
    (at-path ?f - file ?p - path)
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
    :precondition (and (profile-known)
                       (passwords-known)
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (not (task-completed)))
    :effect (directory-listed ?d))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (in-directory ?f ?d)
                       (directory-listed ?d)
                       (not (moved ?f))
                       (not (task-completed)))
    :effect (known-creation-date ?f))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?f - file ?dest - path ?t - token ?d - directory ?fy - year ?cy - year)
    :precondition (and (has-token file-system ?t)
                       (known-creation-date ?f)
                       (current-date-known)
                       (current-year ?cy)
                       (file-year ?f ?fy)
                       (destination-dir ?fy ?cy ?d)
                       (path-in-directory ?dest ?d)
                       (prefixed-path ?dest ?f)
                       (not (moved ?f))
                       (not (task-completed)))
    :effect (and (moved ?f)
                 (at-path ?f ?dest)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (moved file-1)
                       (moved file-2)
                       (moved file-3)
                       (moved file-4)
                       (not (task-completed)))
    :effect (task-completed)))
