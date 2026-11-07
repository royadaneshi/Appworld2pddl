(define (domain appworld-34d9492-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token directory file filepath month count - object)
  (:constants
    file-system phone - app
    count-0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (listed ?d - directory)
    (located ?f - file ?d - directory)
    (created-in ?f - file ?m - month)
    (known-created-in ?f - file)
    (month-destination ?m - month ?d - directory)
    (dest-path ?p - filepath ?f - file ?d - directory)
    (count-successor ?lower - count ?higher - count)
    (files-remaining ?n - count)
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
    :effect (and (current-date-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known)
                       (supervisor-username ?u)
                       (passwords-known)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (not (task-completed)))
    :effect (and (listed ?d)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and (has-token file-system ?t)
                       (located ?f ?d)
                       (listed ?d)
                       (not (task-completed)))
    :effect (and (known-created-in ?f)))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?f - file ?p - filepath ?t - token ?from - directory ?to - directory ?m - month ?n - count ?n1 - count)
    :precondition (and (has-token file-system ?t)
                       (current-date-known)
                       (located ?f ?from)
                       (known-created-in ?f)
                       (created-in ?f ?m)
                       (month-destination ?m ?to)
                       (dest-path ?p ?f ?to)
                       (not (= ?from ?to))
                       (files-remaining ?n)
                       (count-successor ?n1 ?n)
                       (not (task-completed)))
    :effect (and (not (located ?f ?from))
                 (located ?f ?to)
                 (not (files-remaining ?n))
                 (files-remaining ?n1)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (files-remaining count-0)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
