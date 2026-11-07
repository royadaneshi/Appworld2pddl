(define (domain appworld-68ee2c9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory file filepath year - object)
  (:constants file-system phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-directory ?f - file ?d - directory)
    (file-at ?f - file ?p - filepath)
    (directory-listed ?d - directory)
    (creation-date-known ?f - file)
    (created-in-year ?f - file ?y - year)
    (year-destination ?y - year ?d - directory)
    (prefixed-path ?f - file ?d - directory ?p - filepath)
    (renamed ?f - file)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (current-date-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (directory-listed ?d))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?p - filepath ?t - token ?f - file ?d - directory)
    :precondition (and (has-token file-system ?t) (directory-listed ?d) (in-directory ?f ?d) (file-at ?f ?p) (not (task-completed)))
    :effect (creation-date-known ?f))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?f - file ?y - year ?d - directory)
    :precondition (and (has-token file-system ?t) (file-at ?f ?src) (creation-date-known ?f) (current-date-known) (created-in-year ?f ?y) (year-destination ?y ?d) (prefixed-path ?f ?d ?dst) (not (renamed ?f)) (not (task-completed)))
    :effect (and (not (file-at ?f ?src)) (file-at ?f ?dst) (renamed ?f)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f1 - file ?f2 - file)
    :precondition (and (renamed ?f1) (renamed ?f2) (not (= ?f1 ?f2)) (not (task-completed)))
    :effect (task-completed))
)
