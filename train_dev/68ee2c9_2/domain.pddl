(define (domain appworld-68ee2c9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token file filepath dirpath year count - object)
  (:constants
    supervisor file-system phone - app
    count-0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (task-completed)
    (is-supervisor ?p - person)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (listed ?d - dirpath)
    (path-in-dir ?p - filepath ?d - dirpath)
    (file-at ?f - file ?p - filepath)
    (prefixed-path ?f - file ?p - filepath)
    (file-year ?f - file ?y - year)
    (dest-dir-for-year ?y - year ?d - dirpath)
    (creation-date-known ?f - file)
    (renamed ?f - file)
    (pending-files ?n - count)
    (next-count ?lower - count ?higher - count))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action file-system-login
    ; API: file_system.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  (:action phone-get-current-date-and-time
    ; API: phone.get_current_date_and_time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  (:action file-system-show-directory
    ; API: file_system.show_directory
    :parameters (?t - token ?d - dirpath)
    :precondition (and (not (task-completed))
                       (has-token file-system ?t))
    :effect (listed ?d))

  (:action file-system-show-file
    ; API: file_system.show_file
    :parameters (?p - filepath ?t - token ?f - file ?d - dirpath)
    :precondition (and (not (task-completed))
                       (has-token file-system ?t)
                       (file-at ?f ?p)
                       (path-in-dir ?p ?d)
                       (listed ?d))
    :effect (creation-date-known ?f))

  (:action file-system-move-file
    ; API: file_system.move_file
    :parameters (?src - filepath ?dst - filepath ?t - token ?f - file ?y - year ?d - dirpath ?n - count ?m - count)
    :precondition (and (not (task-completed))
                       (has-token file-system ?t)
                       (file-at ?f ?src)
                       (not (renamed ?f))
                       (creation-date-known ?f)
                       (current-date-known)
                       (file-year ?f ?y)
                       (dest-dir-for-year ?y ?d)
                       (prefixed-path ?f ?dst)
                       (path-in-dir ?dst ?d)
                       (pending-files ?n)
                       (next-count ?m ?n))
    :effect (and (not (file-at ?f ?src))
                 (file-at ?f ?dst)
                 (renamed ?f)
                 (not (pending-files ?n))
                 (pending-files ?m)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters ()
    :precondition (and (not (task-completed))
                       (pending-files count-0))
    :effect (task-completed))
)
