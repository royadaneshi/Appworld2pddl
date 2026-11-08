(define (domain appworld-33e202d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query datetime email-thread applicant attachment path content - object
  )
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (position-query ?q - query)
    (window-start ?dt - datetime)
    (thread-found ?th - email-thread)
    (thread-of ?th - email-thread ?ap - applicant)
    (applicant-info-known ?ap - applicant)
    (attachment-of ?att - attachment ?ap - applicant)
    (download-path-for ?att - attachment ?p - path)
    (downloaded ?att - attachment)
    (attachments-downloaded)
    (csv-file ?p - path ?c - content)
    (csv-source ?c - content ?ap - applicant)
    (applications-csv-created)
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
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?dt - datetime ?th - email-thread)
    :precondition (and (has-token gmail ?t) (position-query ?q) (window-start ?dt) (not (task-completed)))
    :effect (and (thread-found ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?ap - applicant)
    :precondition (and (has-token gmail ?t) (thread-found ?th) (thread-of ?th ?ap) (not (task-completed)))
    :effect (and (applicant-info-known ?ap))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?fst - token ?t - token ?p - path ?ap - applicant)
    :precondition (and (has-token file-system ?fst) (has-token gmail ?t) (attachment-of ?att ?ap) (applicant-info-known ?ap) (download-path-for ?att ?p) (not (downloaded ?att)) (not (task-completed)))
    :effect (and (downloaded ?att) (attachments-downloaded))
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - path ?t - token ?c - content ?ap - applicant)
    :precondition (and (has-token file-system ?t) (csv-file ?p ?c) (csv-source ?c ?ap) (applicant-info-known ?ap) (not (applications-csv-created)) (not (task-completed)))
    :effect (and (applications-csv-created))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (applications-csv-created) (attachments-downloaded) (not (task-completed)))
    :effect (and (task-completed))
  )
)
