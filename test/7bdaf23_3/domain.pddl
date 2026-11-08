(define (domain appworld-7bdaf23-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread email attachment path - object)
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (thread-matches ?q - query ?th - email-thread)
    (thread-contains ?th - email-thread ?e - email)
    (email-has-attachment ?e - email ?at - attachment)
    (ticket-attachment ?at - attachment)
    (target-directory ?p - path)
    (known-thread ?th - email-thread)
    (known-email-id ?e - email)
    (known-attachment ?at - attachment)
    (downloaded ?at - attachment ?p - path)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (and (known-thread ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?e - email)
    :precondition (and (has-token gmail ?t) (known-thread ?th) (thread-contains ?th ?e) (not (task-completed)))
    :effect (and (known-email-id ?e)))

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?e - email ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (known-email-id ?e) (email-has-attachment ?e ?at) (not (task-completed)))
    :effect (and (known-attachment ?at)))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?ft - token ?t - token ?p - path)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-attachment ?at) (not (task-completed)))
    :effect (and (downloaded ?at ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?at - attachment ?p - path)
    :precondition (and (ticket-attachment ?at) (target-directory ?p) (downloaded ?at ?p) (not (task-completed)))
    :effect (and (task-completed)))
)
