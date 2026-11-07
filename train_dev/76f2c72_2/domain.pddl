(define (domain appworld-76f2c72-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory bill-file amount - object
  )
  (:constants
    file-system phone - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (current-year-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-directory ?f - bill-file ?d - directory)
    (directory-listed ?d - directory)
    (bill-this-year ?f - bill-file)
    (file-read ?f - bill-file)
    (running-total ?amt - amount)
    (adds-to ?f - bill-file ?prev - amount ?new - amount)
    (final-total ?amt - amount)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (username-for file-system ?u)
      (password-for file-system ?pw)
      (not (has-token file-system ?t))
    )
    :effect (and (has-token file-system ?t))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-year-known))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?d - directory ?t - token)
    :precondition (and
      (not (task-completed))
      (has-token file-system ?t)
    )
    :effect (and (directory-listed ?d))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - bill-file ?t - token ?d - directory ?prev - amount ?new - amount)
    :precondition (and
      (not (task-completed))
      (has-token file-system ?t)
      (in-directory ?f ?d)
      (directory-listed ?d)
      (current-year-known)
      (bill-this-year ?f)
      (not (file-read ?f))
      (running-total ?prev)
      (adds-to ?f ?prev ?new)
    )
    :effect (and
      (file-read ?f)
      (not (running-total ?prev))
      (running-total ?new)
    )
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and
      (not (task-completed))
      (running-total ?ans)
      (final-total ?ans)
    )
    :effect (and (task-completed))
  )
)
