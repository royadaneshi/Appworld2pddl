(define (domain appworld-7bdaf23-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query thread email-message attachment location flight-date path - object
  )
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (thread-matches ?th - thread ?q - query)
    (email-in-thread ?e - email-message ?th - thread)
    (attachment-of ?at - attachment ?e - email-message)
    (ticket-to ?e - email-message ?loc - location)
    (ticket-date ?e - email-message ?d - flight-date)
    (target-location ?loc - location)
    (this-weekend ?d - flight-date)
    (downloads-folder ?p - path)
    (known-thread ?th - thread)
    (known-email-id ?e - email-message)
    (known-attachment ?at - attachment)
    (found-ticket ?at - attachment ?loc - location ?d - flight-date)
    (downloaded ?at - attachment ?p - path)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (thread-matches ?th ?q))
    :effect (and (known-thread ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?e - email-message)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-thread ?th) (email-in-thread ?e ?th))
    :effect (and (known-email-id ?e))
  )

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?e - email-message ?t - token ?at - attachment ?loc - location ?d - flight-date)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-email-id ?e) (attachment-of ?at ?e) (ticket-to ?e ?loc) (ticket-date ?e ?d))
    :effect (and (known-attachment ?at) (found-ticket ?at ?loc ?d))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?p - path)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?fst) (known-attachment ?at) (downloads-folder ?p))
    :effect (and (downloaded ?at ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?at - attachment ?loc - location ?d - flight-date ?p - path)
    :precondition (and (not (task-completed)) (downloaded ?at ?p) (found-ticket ?at ?loc ?d) (target-location ?loc) (this-weekend ?d) (downloads-folder ?p))
    :effect (and (task-completed))
  )
)
