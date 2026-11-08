(define (domain appworld-33e202d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime thread attachment path content - object
    applicant - person
  )
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (search-query ?q - query)
    (search-min-date ?d - datetime)
    (applications-found)
    (application-thread ?th - thread)
    (thread-of ?ap - applicant ?th - thread)
    (attachment-in ?att - attachment ?th - thread)
    (found-thread-details ?th - thread)
    (known-applicant-info ?ap - applicant)
    (csv-file ?p - path ?c - content)
    (listed-in ?ap - applicant ?c - content)
    (download-path ?att - attachment ?p - path)
    (file-created ?p - path ?c - content)
    (attachment-downloaded ?att - attachment ?p - path)
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
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?d - datetime)
    :precondition (and (has-token gmail ?t) (search-query ?q) (search-min-date ?d) (not (task-completed)))
    :effect (applications-found)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?ap - applicant)
    :precondition (and (has-token gmail ?t) (applications-found) (application-thread ?th) (thread-of ?ap ?th) (not (task-completed)))
    :effect (and (found-thread-details ?th) (known-applicant-info ?ap))
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - path ?t - token ?c - content ?ap - applicant)
    :precondition (and (has-token file-system ?t) (csv-file ?p ?c) (listed-in ?ap ?c) (known-applicant-info ?ap) (not (task-completed)))
    :effect (file-created ?p ?c)
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?ft - token ?t - token ?p - path ?th - thread)
    :precondition (and (has-token file-system ?ft) (has-token gmail ?t) (attachment-in ?att ?th) (found-thread-details ?th) (download-path ?att ?p) (not (task-completed)))
    :effect (attachment-downloaded ?att ?p)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - path ?c - content ?att - attachment ?dp - path)
    :precondition (and (csv-file ?p ?c) (file-created ?p ?c) (download-path ?att ?dp) (attachment-downloaded ?att ?dp) (not (task-completed)))
    :effect (task-completed)
  )
)
