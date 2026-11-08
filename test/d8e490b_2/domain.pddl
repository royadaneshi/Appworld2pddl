(define (domain appworld-d8e490b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query dir-path flag email-thread attachment file-path - object
  )
  (:constants
    supervisor gmail file-system - app
    attachment-slides attachment-recording - attachment
    path-slides-2023-05-16 path-recording-2023-05-16 - file-path
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (structure-known)
    (thread-matches ?q - query ?th - email-thread)
    (known-id ?th - email-thread)
    (thread-inspected ?th - email-thread)
    (attached-to ?at - attachment ?th - email-thread)
    (target-path ?at - attachment ?p - file-path)
    (downloaded ?at - attachment ?p - file-path)
    (task-completed)
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
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dir-path ?r - flag)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (and (structure-known))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?th) (not (task-completed)))
    :effect (and (thread-inspected ?th))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?p - file-path ?th - email-thread)
    :precondition (and (has-token file-system ?fst) (has-token gmail ?t) (thread-inspected ?th) (attached-to ?at ?th) (structure-known) (target-path ?at ?p) (not (task-completed)))
    :effect (and (downloaded ?at ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (downloaded attachment-slides path-slides-2023-05-16) (downloaded attachment-recording path-recording-2023-05-16) (not (task-completed)))
    :effect (and (task-completed))
  )
)
