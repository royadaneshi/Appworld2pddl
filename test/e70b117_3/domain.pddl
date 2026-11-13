(define (domain appworld-e70b117-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread directory-path file-path recipient-list subject body datetime - object
  )
  (:constants
    supervisor gmail file-system - app
    reminder-datetime-1 reminder-datetime-2 reminder-datetime-3 reminder-datetime-4 reminder-datetime-5 reminder-datetime-6 reminder-datetime-7 reminder-datetime-8 - datetime
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (schedule-query ?q - query)
    (schedule-thread ?th - email-thread)
    (known-id ?th - email-thread)
    (schedule-known)
    (company-members ?r - recipient-list)
    (known-recipients ?r - recipient-list)
    (in-directory ?f - file-path ?d - directory-path)
    (template-file ?f - file-path)
    (known-file ?f - file-path)
    (template-known)
    (reminder-subject ?s - subject)
    (body-for ?dt - datetime ?b - body)
    (draft-scheduled ?dt - datetime)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (schedule-query ?q) (schedule-thread ?th) (not (task-completed)))
    :effect (known-id ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?r - recipient-list)
    :precondition (and (has-token gmail ?t) (known-id ?th) (schedule-thread ?th) (company-members ?r) (not (task-completed)))
    :effect (and (schedule-known) (known-recipients ?r))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?f - file-path)
    :precondition (and (has-token file-system ?t) (in-directory ?f ?d) (not (task-completed)))
    :effect (known-file ?f)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (has-token file-system ?t) (known-file ?f) (template-file ?f) (not (task-completed)))
    :effect (template-known)
  )

  ; API: gmail.create_draft
  (:action gmail-create-draft
    :parameters (?r - recipient-list ?b - body ?t - token ?s - subject ?dt - datetime)
    :precondition (and (has-token gmail ?t) (known-recipients ?r) (schedule-known) (template-known) (reminder-subject ?s) (body-for ?dt ?b) (not (draft-scheduled ?dt)) (not (task-completed)))
    :effect (draft-scheduled ?dt)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (draft-scheduled reminder-datetime-1)
      (draft-scheduled reminder-datetime-2)
      (draft-scheduled reminder-datetime-3)
      (draft-scheduled reminder-datetime-4)
      (draft-scheduled reminder-datetime-5)
      (draft-scheduled reminder-datetime-6)
      (draft-scheduled reminder-datetime-7)
      (draft-scheduled reminder-datetime-8)
      (not (task-completed)))
    :effect (task-completed)
  )
)
