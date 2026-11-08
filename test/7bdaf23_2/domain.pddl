(define (domain appworld-7bdaf23-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query path - object
    record - object
    email-thread email attachment - record
  )
  (:constants gmail file-system supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (thread-matches ?th - email-thread ?q - query)
    (thread-has-email ?th - email-thread ?e - email)
    (email-has-attachment ?e - email ?at - attachment)
    (is-santorini-weekend-ticket ?at - attachment)
    (download-dir ?p - path)
    (known-id ?x - record)
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
    :precondition (and (passwords-known) (password-for gmail ?pw) (token-of gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (token-of file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?th ?q) (not (task-completed)))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?e - email)
    :precondition (and (has-token gmail ?t) (known-id ?th) (thread-has-email ?th ?e) (not (task-completed)))
    :effect (and (known-id ?e))
  )

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?e - email ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?e) (email-has-attachment ?e ?at) (not (task-completed)))
    :effect (and (known-id ?at))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?p - path)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?at) (is-santorini-weekend-ticket ?at) (download-dir ?p) (not (downloaded ?at ?p)) (not (task-completed)))
    :effect (and (downloaded ?at ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?at - attachment ?p - path)
    :precondition (and (downloaded ?at ?p) (is-santorini-weekend-ticket ?at) (download-dir ?p) (not (task-completed)))
    :effect (and (task-completed))
  )
)
